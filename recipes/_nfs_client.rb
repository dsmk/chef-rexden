if node['platform_family'] == 'rhel'

  package 'nfs-utils'

  service 'rpcbind' do
    action :enable
    action :start
  end

  service 'nfs-lock' do
    action :enable
    action :start
  end

end

# vi: expandtab ts=2 
