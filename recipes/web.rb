include_recipe 'rexden'

case node[:os]
when 'linux'
  include_recipe 'rexden::_web_unix'
when 'windows'
  log "not yet implemented"
end

# common controls no matter where the web server comes from
#
control_group "Validate web services" do
  control "Ensure that the web server is listening on port 80" do
    it "listening on port 80" do
      expect(port(80)).to be_listening
    end
  end
end

# vi: expandtab ts=2 
