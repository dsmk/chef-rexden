include_recipe 'epel'

%w{
 binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms
}.each do |pkg| 
  package pkg
end

#remote_file '/root/epel-release-7-5.noarch.rpm' do
#  source "http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm"
#  owner 'root'
#  group 'root'
#  action :create
#end

#rpm_package 'epel-release' do
#  source "/root/epel-release-7-5.noarch.rpm"
#  action :install
#end

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
#remote_file '/root/VirtualBox-5.0-5.0.11_104721_el7-1.x86_64.rpm' do
#  source "https://www.virtualbox.org/download/testcase/VirtualBox-5.0-5.0.11_104721_el7-1.x86_64.rpm"
##remote_file '/root/VirtualBox-5.0-5.0.10_104061_el7-1.x86_64.rpm' do
##  source "http://download.virtualbox.org/virtualbox/5.0.10/VirtualBox-5.0-5.0.10_104061_el7-1.x86_64.rpm"
#  owner 'root'
#  group 'root'
#  action :create
#end

#package "VirtualBox" do
#  source '/root/VirtualBox-5.0-5.0.11_104721_el7-1.x86_64.rpm' 
#  #source "/root/VirtualBox-5.0-5.0.10_104061_el7-1.x86_64.rpm"
#  action :install
#end
