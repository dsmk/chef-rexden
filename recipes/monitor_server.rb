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

icinga2_environment 'rexden_vmware' do
  environment 'test'
  cluster_attribute 'rexden'
  application_attribute 'vmware'
end

node['rexden']['monitor_vmware'].each do |vhost|
  icinga2_host vhost[:name] do
    template true
    address vhost[:ip]
    max_check_attempts 5
    check_interval '1m'
    check_command 'ping4'
  end
end

# instead we need to include monitoring rules for our environment
# we should also add nrpe to our rexden default.
#
