if node['platform'] == 'redhat'
  #rhsm_repo 'rhel-7-server-optional-rpms'
  rhsm_repo 'rhel-7-server-extras-rpms'
end

package "docker"

service "docker" do
  action [ :enable, :start ]
end

template '/etc/sysconfig/docker' do
  source 'sysconfig.docker.erb'
  user 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[docker]', :immediately
end

# this allows anyone in the wheel group to do sudo docker without a password
#
cookbook_file '/etc/sudoers.d/docker' do
  source 'sudoers.docker'
  user 'root'
  group 'root'
  mode '0600'
end

if node['rexden']['docker_tcp']
  template '/etc/profile.d/docker.sh' do
    user 'root'
    group 'root'
    mode '0444'
    source 'profiled.docker.erb'
  end
end

# vi: expandtab ts=2 
