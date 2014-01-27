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

bearsunday_nginx_config "/etc/nginx/sites-available/#{node[:bearsunday][:nginx_site]}" do
  application_path node[:bearsunday][:app][:install_path]
  context           node['bearsunday']['nginx_context']
  listen            80
  default_server    true
  server_name       '_'
  fpm_pass          {node['php-fpm']['pool']['www']['listen'].sub('/', 'unix:/')}

  action :install

  notifies :reload, "service[nginx]", :delayed
  subscribes :reload, "bash[install_bear_package]", :immediately if %w{Helloworld Sandbox}.include?(node['bearsunday']['app_name'])
end

nginx_site node[:bearsunday][:nginx_site] do
  enable node[:bearsunday][:nginx_site_enabled]
end
