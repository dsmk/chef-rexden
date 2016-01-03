#include_recipe 'rexden'
include_recipe "selinux::permissive"
include_recipe "yum-epel"
include_recipe 'java'
include_recipe 'elasticsearch'
include_recipe 'mongodb'
include_recipe 'graylog2::default'
include_recipe 'graylog2::server'
include_recipe 'graylog2::web'

service 'elasticsearch' do 
    action [ :enable, :start ]
end

service 'graylog-server' do
	action [ :enable, :start ]
end

service 'graylog-web' do
	action [ :enable, :start ]
end

execute 'graylog-firewalld-install' do
    action :nothing
    command "/usr/bin/firewall-cmd --reload ; /usr/bin/firewall-cmd --add-service=graylog --permanent ; /usr/bin/firewall-cmd --reload"
end

cookbook_file '/etc/firewalld/services/graylog.xml' do
    source 'logs/graylog.xml'
    user 'root'
    group 'root'
    mode '0444'
    only_if "/usr/bin/systemctl status firewalld"
    notifies :run, 'execute[graylog-firewalld-install]', :immediately
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
