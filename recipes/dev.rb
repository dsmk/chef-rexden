include_recipe 'rexcore'
include_recipe 'chef-dk'

case node[:os]
when 'linux'
  include_recipe 'rexcore::_graphical'
  include_recipe 'rexden::_dev_vagrant'
  include_recipe 'rexcore::_docker'
  include_recipe 'rexden::_dev_hub'
when 'windows'
  include_recipe 'rexden::_dev_windows'
end

# vi: expandtab ts=2 
