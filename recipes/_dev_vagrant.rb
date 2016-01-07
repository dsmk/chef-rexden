include_recipe 'yum-epel'

%w{
 binutils gcc make patch libgomp glibc-headers glibc-devel dkms
}.each do |pkg| 
  package pkg
end

kernel_ver = node['kernel']['release'].sub(".el7.#{node['kernel']['machine']}", '')
#log "os_ver=#{node['os_version']} arch=#{node['arch']} kernel_ver=#{kernel_ver}"

# doing the kernel packages for the version we are running
%w( kernel-headers kernel-devel ).each do |pkg|
    package pkg do
      #version "#{ node['kernel']['release']}"
      action :upgrade
      # :latest
      #kernel_ver
    end
end

remote_file "/root/vagrant_#{node['rexden']['vagrant_version'] }_x86_64.rpm" do
  source "https://releases.hashicorp.com/vagrant/#{node['rexden']['vagrant_version'] }/vagrant_#{node['rexden']['vagrant_version'] }_x86_64.rpm"
  owner 'root'
  group 'root'
  action :create
end

rpm_package 'vagrant' do
  source "/root//vagrant_#{node['rexden']['vagrant_version'] }_x86_64.rpm"
  action :install
end

# https://www.virtualbox.org/download/testcase/VirtualBox-5.0-5.0.11_104721_el7-1.x86_64.rpm
remote_file "/root/VirtualBox-5.0-#{node['rexden']['virtualbox_rel']}_el7-1.x86_64.rpm" do
  source "http://download.virtualbox.org/virtualbox/#{node['rexden']['virtualbox_version']}/VirtualBox-5.0-#{node['rexden']['virtualbox_rel']}_el7-1.x86_64.rpm"
  owner 'root'
  group 'root'
  action :create
end

package "VirtualBox-5.0" do
  source "/root/VirtualBox-5.0-#{node['rexden']['virtualbox_rel']}_el7-1.x86_64.rpm"
  action :install
end

# vi: expandtab ts=2 
