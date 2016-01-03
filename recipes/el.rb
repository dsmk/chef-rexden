#
# Cookbook Name:: rexden
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
if node['os'] == 'linux' 
  include_recipe 'rexden::linux'
end

# vi: expandtab ts=2 
