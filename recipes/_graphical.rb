bash 'yum groupinstall GNOME Desktop' do
  user 'root'
  group 'root'
  code <<-EOC
    yum groupinstall "GNOME Desktop" -y
  EOC
  not_if "yum grouplist installed | grep 'GNOME Desktop' "
end

bash 'enable graphical target' do
  user 'root'
  group 'root'
  code <<-EOC
    /usr/bin/systemctl set-default graphical.target
  EOC
  not_if "[ `/usr/bin/systemctl get-default` = graphical.target ]"
end

bash 'switch to graphical target' do
  user 'root'
  group 'root'
  code <<-EOC
    /usr/bin/systemctl isolate graphical.target
  EOC
  not_if "/usr/bin/systemctl list-units --type target | grep graphical.target"
end

# vi: expandtab ts=2 
