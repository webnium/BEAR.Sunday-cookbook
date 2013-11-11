#
# Cookbook Name:: bear-sunday
# Recipe:: nginx
#
# Copyright 2013, Webnium, Inc
#
# BSD
#
include_recipe "nginx"
include_recipe "php-fpm"

application_path = "#{node['bear-sunday']['install_path']}/apps/#{node['bear-sunday']['app_name']}"

template "/etc/nginx/conf.d/default.conf" do
  owner "root"
  group "root"
  mode 0644
  source "nginx.conf.erb"

  notifies :reload, "service[nginx]"

  variables({
    :application_path => application_path,
    :context          => node['bear-sunday']['nginx_context'],
    :port             => 80,
    :default_server   => false,
    :server_name      => '_',
    :fpm_pass         => node['php-fpm']['pool']['www']['listen'].sub('/', 'unix:/')
  })
end

%w{/var/log /var/tmp}.each do |dir|
  directory "#{application_path}#{dir}" do
    group node['php-fpm']['pool']['www']['group']
    mode '0775'
    action :create
    only_if { ::File.exists?(dir) }

    subscribes :create, "bash[install_bear_package]", :immediately if %w{Helloworld Sandbox}.include?(node['bear-sunday']['app_name'])
  end
end

case node['bear-sunday']['nginx_context']
when 'prod'
  execute "bear_precompile" do
    user node['php-fpm']['pool']['www']['user']
    group node['php-fpm']['pool']['www']['group']
    command "php #{application_path}/bin/compiler.php"

    notify :reload, "service[php-fpm]", :immediately

    not_if { ::File.exists?("#{application_path}/var/tmp/preloader/preload.php") }
  end
when 'dev'
  include_recipe 'bear-sunday::develop-environment'
end
