#
# Cookbook Name:: bearsunday
# Provider:: app
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
  Chef::Log.info "Installing #{@new_resource}"

  updated = sync_with_git || change_directory_permissions 
  if updated then
    composer_install
    precomplie
  end

  @new_resource.updated_by_last_action(updated)
end

action :update do
  return unless @current_resource.exists?

  Chef::Log.info "Updating #{@new_resource}"

  updated = sync_with_git || change_directory_permissions 
  if updated then
    composer_install
    precomplie
    clear_cache
  end

  @new_resource.updated_by_last_action(updated)
end

action :uninstall do
  if @current_resource.exists?
    Chef::Log.info "Uninstalling #{@new_resource}"
    file @new_resource.application_path do
      action :delete
      new_resource.updated_by_last_action(true)
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::BearsundayApp.new(@new_resource.name)
  @current_resource.application_path(@new_resource.application_path)
end

private

def sync_with_git do
  resource = @new_resource
  g = git @new_resource.application_path do
    repository resource.source
    reference resource.source_reference
    action :sync

    user resource.user 
    group resource.group 
  end
  g.updated_by_last_action?
end

def change_directory_permissions
  resource = @new_resource
  updated = false
  %w{/var/log /var/tmp}.each do |dir|
    d = directory "#{@new_resource.application_path}#{dir}" do
      user resource.user 
      group resource.group 
      mode '0775'
      action :create
      only_if { ::File.exists?(dir) }
    end
    updated = updated || d.updated_by_last_action?
  end
  return updated
end

def composer_install do
  resource = @new_resource
  options = []

  if @new_resource.for_production then
    options.push('--no-dev')
    options.push('--optimize-autoloader')
  end

  case @new_resource.composer_prefer
  when 'source'
    options.push('--prefer-source')
  when 'dist'
    options.push('--prefer-dist')
  end

  execute "composer-install-on-#{resource.application_path}" do
    cwd resource.application_path
    user resource.user

    command "composer install #{options.join(' ')}"
  end
end

def precomplie do
  resourece = @new_resource
  execute "precompile-on-#{resource.application_path}" do
    group resource.group
    user  resource.user

    command "php #{resource.application_path}/bin/compiler.php"
  end
end

def clear_cache do
  resourece = @new_resource
  execute "clear-cache-on-#{resource.application_path}" do
    group resource.group
    user  resource.user

    command "php #{resource.application_path}/bin/clear.php"
  end
end
