#
# Cookbook Name:: bearsunday
# Recipe:: default
#
# Copyright 2013, Webnium, Inc
#
# BSD
#
include_recipe 'bearsunday::environment'

%w{php-pecl-xhprof php-pecl-xdebug}.each do |pkg|
  package pkg do
    action :install
  end
end
