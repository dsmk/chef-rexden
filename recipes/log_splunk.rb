#include_recipe 'rexden'
include_recipe "selinux::permissive"
include_recipe "yum-epel"

group 'splunk' do
    gid '890'
end

user 'splunk' do
    uid "890"
    gid "splunk"
end

remote_file "/tmp/splunk-#{node['rexden']['splunk_version']}.rpm" do
    source node['rexden']['splunk_download_url']
    user "root"
    group "root"
    mode "0555"
end

package "splunk-#{node['rexden']['splunk_version']}" do
    source "/tmp/splunk-#{node['rexden']['splunk_version']}.rpm"
end

#include_recipe 'java'
#include_recipe 'elasticsearch'
#include_recipe 'mongodb'
#include_recipe 'graylog2::default'
#include_recipe 'graylog2::server'
#include_recipe 'graylog2::web'

#service 'elasticsearch' do 
#    action [ :enable, :start ]
#end

#service 'graylog-server' do
#	action [ :enable, :start ]
#end

#service 'graylog-web' do
#	action [ :enable, :start ]
#end

execute 'splunk-firewalld-install' do
    action :nothing
    command "/usr/bin/firewall-cmd --reload ; /usr/bin/firewall-cmd --add-service=splunk --permanent ; /usr/bin/firewall-cmd --reload"
end

cookbook_file '/etc/firewalld/services/splunk.xml' do
    source 'logs/splunk.xml'
    user 'root'
    group 'root'
    mode '0444'
    only_if "/usr/bin/systemctl status firewalld"
    notifies :run, 'execute[splunk-firewalld-install]', :immediately
end

execute 'splunk-firewalld-restart' do
    action :nothing
    command "/usr/bin/firewall-cmd --reload"
end

cookbook_file '/etc/firewalld/direct.xml' do
    source 'logs/splunk-direct.xml'
    user 'root'
    group 'root'
    mode '0644'
    only_if "/usr/bin/systemctl status firewalld"
    notifies :run, 'execute[splunk-firewalld-restart]', :immediately
end

cookbook_file '/usr/lib/systemd/system/splunk.service' do
    source 'logs/splunk.service'
    user "root"
    group "root"
    mode "0755"
end

link '/usr/bin/splunk' do
    to '/opt/splunk/bin/splunk'
end

execute 'splunk-accept-license' do
    command "/opt/splunk/bin/splunk start --accept-license >/var/log/splunk-accept-license.log 2>&1"
    creates "/var/log/splunk-accept-license.log"
end

service 'splunk' do
    action [ :enable, :start ]
end

template "/opt/splunk/etc/system/local/inputs.conf" do
    source "logs/splunk-inputs.conf.erb"
    user "root"
    group "root"
    mode "0644"
end

# port 9000 is the graylog web interface
# port 12900 is for ?
# port 5544 for syslog (tcp and udp)
# port x for GELF
#[ 9000, 12900 ].each do |port|
#    firewall_rule "open_port_#{port}" do
#        port port
#        protocol :tcp
#        position 1
#        command :allow
#    end
#end

# vi: expandtab ts=2 
