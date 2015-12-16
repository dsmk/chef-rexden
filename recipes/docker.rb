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

