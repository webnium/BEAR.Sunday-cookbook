#
# Cookbook Name:: bearsunday
# Resource:: nginx_config
#
# Copyright 2013, Webnium, Inc
#
# BSD
#

default_action :install
actions :install, :uninstall, :reload

attribute :config_path, :kind_of => String, :name_attribute => true
attribute :application_path, :kind_of => String, :required => true
attribute :server_name, :kind_of => String, :default => '_'
attribute :default_server, :kind_of => [TrueClass, FalseClass], :default => true
attribute :listen, :kind_of => [String, Integer], :default => '80'
attribute :context, :kind_of => String, :default => 'prod'
attribute :fpm_pass, :kind_of => String, :default => node['php-fpm']['pool']['www']['listen'].sub('/', 'unix:/')

def exists?
  ::File.exists?(@config_path)
end
