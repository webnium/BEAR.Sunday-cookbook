#
# Cookbook Name:: bearsunday
# Recipe:: default
#
# Copyright 2013, Webnium, Inc
#
# BSD
#
include_recipe "bearsunday::environment"

bash "install_bear_package" do
  user "root"
  code <<-EOT
    rm -rf #{node['bearsunday']['install_path']} > /dev/null 2>&1
    composer create-project --keep-vcs --prefer-source bear/package #{node['bearsunday']['install_path']} #{node['bearsunday']['version']}
  EOT
  not_if { ::File.exists?(node['bearsunday']['install_path'] + "/ID") }
end

