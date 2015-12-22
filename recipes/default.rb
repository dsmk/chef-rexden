#
# Cookbook Name:: rexden
# Recipe:: default
#
# This is our default client recipe which is designed to be used by many different systems
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
if node['os'] == 'linux' 
  include_recipe 'rexden::linux'
end
