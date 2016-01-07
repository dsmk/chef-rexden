# Set up our web server
#
#
package "httpd"

service "httpd" do
  action [ :enable, :start ]
end

cookbook_file "/etc/httpd/conf.d/server.conf" do
  source "web/server.conf"
  user "root"
  group "root"
  mode "0444"
  notifies :restart, 'service[httpd]', :immediately
end

directory '/var/www/server' do
  user 'root'
  group 'root'
  mode '0755'
end

if node['httpd']['do_php']
  package 'php' do
    notifies :restart, 'service[httpd]', :immediately
  end

  cookbook_file "/var/www/server/phpinfo.php" do
    source "web/phpinfo.php"
    user "root"
    group "root"
    mode "0444"
  end
end

# ####
# Audit controls
#
control_group 'Validate web services unix specific tests' do
  control 'Ensure no web files are owned by the root user' do
    Dir.glob('/var/www/html/**/*') do |web_file|
      it "#{web_file} is not owned by the root user" do
        expect(file(web_file)).to_not be_owned_by('root')
      end
    end
  end
end
