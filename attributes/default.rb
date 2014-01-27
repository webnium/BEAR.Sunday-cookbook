#
# Cookbook Name:: bearsunday
# Attributes:: default
#
# Copyright 2013, Webnium, Inc
#
# BSD
#
default["bearsunday"]["install_path"]  = "/usr/local/lib/bear"
default["bearsunday"]["version"]       = "dev-develop"
default["bearsunday"]["app_name"]      = "Sandbox"
default["bearsunday"]["nginx_context"] = "prod"
default["bearsunday"]["nginx_site"]    = "bearsunday"
default["bearsunday"]["nginx_site_enabled"] = true
default["bearsunday"]["app"]["install_path"] = "#{node['bearsunday']['install_path']}/apps/#{node['bearsunday']['app_name']}"
default["bearsunday"]["app"]["version"] = "master"
default["bearsunday"]["app"]["for_production"] = true
default["bearsunday"]["app"]["composer_prefer"] = "dist"
