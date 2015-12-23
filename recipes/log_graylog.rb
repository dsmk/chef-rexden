#include_recipe 'rexden'
include_recipe 'java'
include_recipe 'elasticsearch'
include_recipe 'mongodb'
include_recipe 'graylog2::default'
include_recipe 'graylog2::server'
include_recipe 'graylog2::web'

service 'elasticsearch' do 
    action [ :enable, :start ]
end

service 'graylog-server' do
	action [ :enable, :start ]
end

service 'graylog-web' do
	action [ :enable, :start ]
end

