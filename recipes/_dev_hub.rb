#https://github.com/github/hub/releases/download/v2.2.2/hub-linux-amd64-2.2.2.tgz

#kernel_ver = node['kernel']['release'].sub(".el7.#{node['kernel']['machine']}", '')
#log "os_ver=#{node['os_version']} arch=#{node['arch']} kernel_ver=#{kernel_ver}"
hub_version= node['rexden']['hub_version']
hub_fname="hub-linux-amd64-#{hub_version}"
hub_url="https://github.com/github/hub/releases/download/v#{hub_version}/#{hub_fname}.tgz"

remote_file "/root/#{hub_fname}.tgz" do
  source hub_url
  owner 'root'
  group 'root'
  action :create
end

execute "uncompress hub in /opt" do
  cwd "/opt"
  command "/bin/tar -C /opt -xzvf '/root/#{hub_fname}.tgz' "
  not_if "[ -d /opt/#{hub_fname} ]"
end

link '/usr/bin/hub' do
  to "/opt/#{hub_fname}/bin/hub"
end

# vi: expandtab ts=2 
