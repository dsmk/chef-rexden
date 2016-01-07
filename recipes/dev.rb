include_recipe 'rexden'

case node[:os]
when 'linux'
  include_recipe 'rexden::_graphical'
  include_recipe 'rexden::_dev_vagrant'
  include_recipe 'rexden::_docker'
when 'windows'
  include_recipe 'rexden::_dev_windows'
end

# vi: expandtab ts=2 
