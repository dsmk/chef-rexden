
#include_recipe 'rexden::users::all'

%w[
  vim-enhanced
  git
  tcsh
  lsof
  dstat
  sysstat
  strace
].each do |pkg|
  package pkg
end

cookbook_file '/etc/init.d/rexden_functions' do
  owner 'root'
  group 'root'
  mode '0555'
  source 'rexden_functions'
end

cookbook_file '/usr/bin/bkupfile' do
  owner 'root'
  group 'root'
  mode '0555'
  source 'bkupfile'
end

template '/etc/ssh/shosts.equiv' do
  owner 'root'
  group 'root'
  mode '0444'
  source 'shosts.equiv.erb'
end

template '/root/.shosts' do
  owner 'root'
  group 'root'
  mode '0444'
  source 'shosts.equiv.erb'
end

template '/etc/ssh/ssh_known_hosts' do
  owner 'root'
  group 'root'
  mode '0444'
  source 'ssh_known_hosts.erb'
end

if node['platform_family'] == 'rhel'
  # only do the remote syslog server set up if we specific a log server
  if node['rexden']['syslog_server'] != 'none'

    template '/etc/rsyslog.d/10-logserver.conf' do
      source '10-logserver.conf.erb'
      owner 'root'
      group 'root'
      mode '0755'
      notifies :restart, 'service[rsyslog]', :immediately
    end

    service 'rsyslog' do
      action [ :enable, :start ]
    end
  end
end

#if node['platform'] == 'redhat'
  #rhsm_repo 'rhel-7-server-optional-rpms'
#  rhsm_repo 'rhel-7-server-extras-rpms'
#end

package "net-snmp"

service 'snmpd' do
  action [ :enable, :start ]
end


# vi: expandtab ts=2 
