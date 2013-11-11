#
# Cookbook Name:: bear-sunday
# Recipe:: default
#
# Copyright 2013, Webnium, Inc
#
# BSD
#
include_recipe "bear-sunday::environment"

bash "install_bear_package" do
  user "root"
  code <<-EOT
    rm -rf #{node['bear-sunday']['install_path']} > /dev/null 2>&1
    composer create-project --prefer-source bear/package #{node['bear-sunday']['install_path']} #{node['bear-sunday']['version']}
  EOT
  not_if { ::File.exists?(node['bear-sunday']['install_path'] + "/ID") }
end