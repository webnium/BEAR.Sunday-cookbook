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
attribute :source_reference, :kind_of => String, :default => 'master'
attribute :user, :kind_of => String, :default => nil
attribute :group, :kind_of => String, :default => nil
attribute :version, :kind_of => String, :default => ''

def exists?
  ::File.exists?(@application_path)
end
