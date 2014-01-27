#
# Cookbook Name:: bearsunday
# Resource:: app
#
# Copyright 2013, Webnium, Inc
#
# BSD
#

default_action :install
actions :install, :uninstall

attribute :application_path, :kind_of => String, :name_attribute => true
attribute :source, :kind_of => String, :required => true
attribute :version, :kind_of => String, :default => 'master'
attribute :user, :kind_of => String, :default => nil
attribute :group, :kind_of => String, :default => nil
attribute :composer_prefer, :kind_of => String, :default => 'dist'
attribute :for_production, :kind_of => [TrueClass, FalseClass], :default => true

def exists?
  ::File.exists?(@application_path)
end
