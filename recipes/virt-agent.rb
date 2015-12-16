if node['platform_family'] == 'rhel'
 
  if node['platform_version'][0].to_i < 7
    log "do old Red Hat version - which entails adding vmware repo and installing tools"
  else
    package 'open-vm-tools'

    service 'vmtoolsd' do
      action :enable
      action :start
    end
  end
else
  log 'different linux platform'
end
# "os": "linux",
#     "os_version": "3.10.0-327.3.1.el7.x86_64",
#       "platform": "redhat",
#         "platform_version": "7.2",
#           "platform_family": "rhel",
#             "uptime_seconds": 4147,
#
