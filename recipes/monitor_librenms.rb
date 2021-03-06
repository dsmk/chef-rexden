include_recipe 'selinux::permissive'
include_recipe 'yum-epel'

#%w( mariadb-server net-snmp mariadb-client ).each do |pkg|
%w( mariadb-server net-snmp git ).each do |pkg|
  package pkg
end

service "mariadb" do
  action [ :enable, :start ]
end

cookbook_file "/usr/sbin/librenms_db_setup.sh" do
  user "root"
  group "root"
  mode "0555"
  source "monitor/librenms_db_setup.sh"
end

execute "create-librenms-db" do
  command "/usr/sbin/librenms_db_setup.sh >/var/log/db-librenms-setup.log 2>&1 "
  creates "/var/log/db-librenms-setup.log"
end

#RRD Log Directory is missing (/opt/librenms/rrd). Graphing may fail.

%w( php php-cli php-gd php-mysql php-snmp php-pear php-curl php-mcrypt httpd rrdtool MySQL-python ).each do |pkg|
  package pkg
end

group "librenms" do
  #gid "980"
end

user "librenms" do
  #uid "980"
  gid "librenms"
end

service "httpd" do
  action [ :enable, :start ]
end

firewall_rule 'http' do
  port 80
  protocol :tcp
  position 1
  command :allow
end

file "/etc/httpd/conf.d/welcome.conf" do
  action :delete
end

cookbook_file "/etc/httpd/conf.d/librenms.conf" do
  user "root"
  group "root"
  source "monitor/librenms.conf"
  notifies :restart, 'service[httpd]', :immediately
end

group "librenms" do
  members [ 'apache', ]
end

directory "/opt/librenms" do
  user "librenms"
  group "librenms"
  mode "0755"
end

git "/opt/librenms" do
  repository "https://github.com/librenms/librenms.git"
  revision "201512"
  user "librenms"
  group "librenms"
end

directory "/opt/librenms/rrd" do
  user "librenms"
  group "librenms"
  mode "0775"
end

directory "/opt/librenms/logs" do
  user "apache"
  group "apache"
  mode "0775"
end

template "/opt/librenms/config.php" do
  source "monitor/config.php.erb"
  user "librenms"
  group "librenms"
  mode "0444"
end

cookbook_file "/etc/cron.d/librenms" do
  source "monitor/librenms.cron"
  user "root"
  group "root"
  mode "0444"
end

%w( Net_IPv4 Net_IPv6 ).each do |pkg|
  execute "ensure #{pkg} pear module installed" do
    command "/bin/pear install #{pkg} >/var/log/pear-#{pkg}.log 2>&1 "
    creates "/var/log/pear-#{pkg}.log"
    returns [ 0, 1 ]
  end
end

# initial database setup
execute "initialize the database" do
  cwd "/opt/librenms"
  command "/bin/php build-base.php >/var/log/librenms-build-base.log 2>&1"
  creates "/var/log/librenms-build-base.log"
end

node['librenms']['users'].each do |user|
  execute "create librenms user #{user[:name]}" do
    cwd "/opt/librenms"
    command "/bin/php ./adduser.php '#{user[:name]}' '#{user[:pass]}' 10 '#{user[:email]}' >/var/log/librenms-user-#{user[:name]}.log 2>&1"
    creates "/var/log/librenms-user-#{user[:name]}.log"
  end
end

node['librenms']['hosts'].each do |host|
  execute "create librenms host #{host[:name]}" do
    cwd "/opt/librenms"
    command "/bin/php ./addhost.php '#{host[:name]}' '#{host[:community]}' '#{host[:version]}' >/var/log/librenms-host-#{host[:name]}.log 2>&1"
    creates "/var/log/librenms-host-#{host[:name]}.log"
  end
end

#
#file "/etc/php.d/timezone.ini" do
#  content "date.timezone = 'America/New_York'"
#  user "root"
#  group "root"
#  mode "0555"
#  notifies :reload, 'service[httpd]', :immediately
#end


# vi: expandtab ts=2 
