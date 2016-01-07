
node['rexden']['dev_packages'].each do |pkg|
  chocolatey pkg
end

# vi: expandtab ts=2 
