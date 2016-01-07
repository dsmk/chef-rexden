include_recipe 'chocolatey'

#log "packages=#{node['chocolatey']['packages']}"

# install the chocolatey packages
node['chocolatey']['packages'].each do |p|
  chocolatey p
end

#include_recipe 'rexden::_win_ad'
