#include_recipe 'rexden'
#include_recipe "selinux::permissive"
#include_recipe "yum-epel"

package "rsyslog"

directory "/opt/logarchive" do
    user "root"
    group "root"
end

service "rsyslog" do
    action [ :enable, :start ]
end

template "/etc/rsyslog.d/60-logserver.conf" do
    source "logs/60-logserver.conf.erb"
    user "root"
    group "root"
    mode "0444"
    notifies :restart, 'service[rsyslog]'
end

#template "/etc/logrotate.d/logserver.conf" do
#    user "root"
#    group "root"
#    mode "0444"
#end

package 'firewalld' 

service 'firewalld' do
    action [ :enable, :start ]
end

execute 'rsyslog-firewalld-install' do
    action :nothing
    command "/usr/bin/firewall-cmd --reload ; /usr/bin/firewall-cmd --add-service=logserver --permanent ; /usr/bin/firewall-cmd --reload"
end

cookbook_file '/etc/firewalld/services/rsyslog.xml' do
    source 'logs/rsyslog.xml'
    user 'root'
    group 'root'
    mode '0444'
    only_if "/usr/bin/systemctl status firewalld"
    notifies :run, 'execute[rsyslog-firewalld-install]', :immediately
end

execute 'rsyslog-firewalld-restart' do
    action :nothing
    command "/usr/bin/firewall-cmd --reload"
end

cookbook_file '/etc/firewalld/direct.xml' do
    source 'logs/rsyslog-direct.xml'
    user 'root'
    group 'root'
    mode '0644'
    only_if "/usr/bin/systemctl status firewalld"
    notifies :run, 'execute[rsyslog-firewalld-restart]', :immediately
end

# vi: expandtab ts=2 
