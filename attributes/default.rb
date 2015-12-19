#
# Cookbook Name:: jetty
# Attributes:: default
#
# Copyright 2010-2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# do not configure rsyslog to send data to a remote log server
default['rexden']['syslog_server'] = 'none'
# you would want to set this in a location or role instead of globally
#default['rexden']['syslog_server'] = 'buckbeak.rexden.us'
# port 514 is the default port for standard syslog
#default['rexden']['syslog_port'] = 514
# port 5544 is the port we used for the ELK-based log server
default['rexden']['syslog_port'] = 5544
default['rexden']['syslog_work_dir'] = '/var/cache/rsyslog'

# Ark client defaults
#
default['rexden']['ark_server_name'] = 'fawkes.rexden.us'
default['rexden']['ark_server_ip'] = '192.168.8.19'
