#
# Cookbook Name:: rexden
# Recipe:: default
#
# This is our default client recipe which is designed to be used by many different systems
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
include_recipe "chef-client"
include_recipe "chef-client::delete_validation"

case node['os']
when 'linux'
  include_recipe 'rexden::linux'
when 'windows'
  include_recipe 'rexden::windows'
end

# vi: expandtab ts=2 
