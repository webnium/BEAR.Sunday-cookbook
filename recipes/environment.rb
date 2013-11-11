#
# Cookbook Name:: bear-sunday
# Recipe:: environment
#
# Copyright 2013, Webnium, Inc
#
# BSD
#

include_recipe 'yum::remi'
include_recipe 'php'
include_recipe 'composer'

%w{php-apc php-pdo php-mysql}.each do |pkg|
  package pkg do
    action :install
  end
end
