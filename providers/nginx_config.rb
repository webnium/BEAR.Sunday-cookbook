#
# Cookbook Name:: bearsunday
# Provider:: nginx_config
#
# Copyright 2013, Webnium, Inc
#
# BSD
#

def whyrun_supported?
  true
end

use_inline_resources

action :install do
  Chef::Log.info "Installing #{@new_resource} for #{@new_resource.application_path} to #{@new_resource.config_path}"
  create_config
  change_directory_permissions
end

action :uninstall do
  if @current_resource.exists?
    Chef::Log.info "Uninstalling #{@new_resource}"
    file @new_resource.config_path do
      action :delete
      new_resource.updated_by_last_action(true)
    end
  end
end

action :reload do
  if @current_resource.exists?
    Chef::Log.info "Reloading #{@new_resource}"

    change_directory_permissions

    new_resource.updated_by_last_action(true)
  end
end

def load_current_resource
  @current_resource = Chef::Resource::BearsundayNginxConfig.new(@new_resource.name)
  @current_resource.config_path(@new_resource.config_path)
end

private
def create_config
  template_variables = {
    :application_path => @new_resource.application_path,
    :context          => @new_resource.context,
    :listen           => @new_resource.listen,
    :default_server   => @new_resource.default_server,
    :server_name      => @new_resource.server_name,
    :fpm_pass         => @new_resource.fpm_pass
  }

  template_source = @new_resource.source

  template @new_resource.config_path do
    owner "root"
    group "root"
    mode 0644

    if template_source
      source template_source
    else
      source "nginx.conf.erb"
      cookbook "bearsunday"
    end

    variables(template_variables)
  end
end

def change_directory_permissions
  updated = false
  %w{/var/log /var/tmp}.each do |dir|
    d = directory "#{@new_resource.application_path}#{dir}" do
      group node['php-fpm']['pool']['www']['group']
      mode '0775'
      action :create
      only_if { ::File.exists?(dir) }
    end
  end
end
