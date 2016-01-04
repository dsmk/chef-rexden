include_recipe 'rexden::_nfs_client'

mroot = node['rexden']['media_root']
mnfs = node['rexden']['media_nfs_prefix']

directory "#{mroot}/music" do
  owner "root"
  group "root"
end

[ 
 { path: "#{mroot}/music/active", remote: "#{mnfs}/music/active" },
 { path: "#{mroot}/music/playlists", remote: "#{mnfs}/music/playlists" },
 { path: "#{mroot}/video", remote: "#{mnfs}/video/rexden" },
 { path: "#{mroot}/video/staging", remote: "#{mnfs}/video/staging", dir_skip: true },
].each do |m|
  log "path=#{m[:path]} remote=#{m[:remote]}"

  if m[:dir_skip] then
    directory m[:path] 
  end

  mount m[:path] do
    device m[:remote]
    fstype 'nfs'
    options 'defaults,ro'
    action [ :enable, :mount ]
  end

end

# vi: expandtab ts=2 
