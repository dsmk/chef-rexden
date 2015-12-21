package "mariadb-server"

service "mariadb" do
  action [ :enable, :start ]
end

cookbook_file "/usr/sbin/icinga_db_setup.sh" do
  user "root"
  group "root"
  mode "0555"
  source "monitor/icinga_db_setup.sh"
end

execute "create-icinga-db" do
  command "/usr/sbin/icinga_db_setup.sh >/var/log/db-icinga-setup.log 2>&1 "
  creates "/var/log/db-icinga-setup.log"
end

include_recipe 'icinga2::default'
include_recipe 'icinga2::server'
#include_recipe 'icinga2-test::default'

# server nagios plugins
#%w( disk http load ping swap users ).each do |name|
#  package "nagios-plugins-#{name}"
#end
package "nagios-plugins-all"

#group "icingaweb2" do
#  gid "994"
#  members [ 'apache', ]
#end
#
#service "httpd" do
#  action [ :enable, :start ]
#end
#
#file "/etc/php.d/timezone.ini" do
#  content "date.timezone = 'America/New_York'"
#  user "root"
#  group "root"
#  mode "0555"
#  notifies :reload, 'service[httpd]', :immediately
#end

#icinga2_environment 'rexden_vmware' do
#  environment 'test'
#  cluster_attribute 'rexden'
#  application_attribute 'vmware'
#end

icinga2_hostgroup 'esxi-hosts' do
  display_name 'VMware ESXi hosts'
end

node['rexden']['host-templates'].each do |tmpl|
  icinga2_host tmpl[:name] do
    template true
    max_check_attempts 5
    check_interval '1m'
    retry_interval '30s'
    check_command tmpl[:cmd]
  end
end

node['rexden']['misc-hosts'].each do |vhost|
  icinga2_host vhost[:name] do
    address vhost[:ip]
    import vhost[:type]
    #group vhost[:group]
    #display_name 
  end
end

# instead we need to include monitoring rules for our environment
# we should also add nrpe to our rexden default.
#
