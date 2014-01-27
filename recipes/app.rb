#
# Cookbook Name:: bearsunday
# Recipe:: nginx
#
# Copyright 2014, Webnium, Inc
#
# BSD
#
bearsunday_app node[:bearsunday][:app][:install_path] do
  source node[:bearsunday][:app][:source]
  version node[:bearsunday][:app][:version]
  composer_prefer node[:bearsunday][:app][:composer_prefer]
  for_production node[:bearsunday][:app][:for_production]

  notifies :reload, "service[php-fpm]", :delayed
end
