#
# Cookbook Name:: bearsunday
# Recipe:: nginx
#
# Copyright 2013, Webnium, Inc
#
# BSD
#
include_recipe "nginx"
include_recipe "php-fpm"

bearsunday_nginx_config "/etc/nginx/conf.d/default.conf" do
  application_path "#{node['bearsunday']['install_path']}/apps/#{node['bearsunday']['app_name']}"
  context           node['bearsunday']['nginx_context']
  listen            80
  default_server    true
  server_name       '_'
  fpm_pass          {node['php-fpm']['pool']['www']['listen'].sub('/', 'unix:/')}

  action :install

  notifies :reload, "service[nginx]", :delayed
  notifies :reload, "service[php-fpm]", :delayed
  subscribes :reload, "bash[install_bear_package]", :immediately if %w{Helloworld Sandbox}.include?(node['bearsunday']['app_name'])
end
