include_recipe 'rexden'
if node['rexden']['media_mount'] then
  include_recipe 'rexden::_media_mounts'
else
  include_recipe 'rexden::_media_local'
end
include_recipe 'rexden::_media_logitech'


# vi: expandtab ts=2 
