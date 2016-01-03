
package 'rsync'

directory '/root/.ssh' do
  user 'root'
  group 'root'
  mode '0700'
end

cookbook_file '/root/.ssh/push-backup' do
  source 'ark/push-backup'
  user 'root'
  group 'root'
  mode '0700'
end

cookbook_file '/usr/sbin/ark' do
  source 'ark/ark'
  user 'root'
  group 'root'
  mode '0755'
end

directory '/etc/ark.d' do
  user 'root'
  group 'root'
  mode '0755'
end

cookbook_file '/etc/ark.d/core.s' do
  source 'ark/ark-core.s'
  user 'root'
  group 'root'
  mode '0700'
end

cookbook_file '/etc/cron.d/ark-cron' do
  source 'ark/ark-cron'
  user 'root'
  group 'root'
  mode '0644'
end

hostsfile_entry node['rexden']['ark_server_ip'] do
  hostname node['rexden']['ark_server_name']
  unique true
end

# vi: expandtab ts=2 
