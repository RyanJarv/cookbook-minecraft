#
# Cookbook Name:: minecraft
# Recipe:: default
#
# Copyright 2013, Greg Fitzgerald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

install_type = node['minecraft']['install_type']

include_recipe "java::#{node['java']['install_flavor']}"
include_recipe 'runit'
include_recipe 'minecraft::user'

jar_name = minecraft_file(node['minecraft'][install_type]['url'])

directory node['minecraft']['install_dir'] do
  recursive true
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0755
  action :create
end

remote_file "#{node['minecraft']['install_dir']}/#{jar_name}" do
  source node['minecraft'][install_type]['url']
  checksum node['minecraft'][install_type]['checksum']
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  action :create_if_missing
end

execute 'create launchwrapper directory' do
  command "mkdir -p #{File.join(node['minecraft']['install_dir'], 'libraries', File.dirname(node['minecraft'][install_type]['launchwrapper']['path']))}"
  user node['minecraft']['user']
  group node['minecraft']['group']
  only_if { node['minecraft'][install_type]['launchwrapper']['path'] }
  not_if { File.exist? File.join(node['minecraft']['install_dir'], 'libraries', File.dirname(node['minecraft'][install_type]['launchwrapper']['path'])) }
end

remote_file File.join(node['minecraft']['install_dir'], 'libraries', node['minecraft'][install_type]['launchwrapper']['path']) do
  source "https://libraries.minecraft.net/#{node['minecraft'][install_type]['launchwrapper']['path']}"
  checksum node['minecraft'][install_type]['launchwrapper']['checksum']
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  not_if { node['minecraft'][install_type]['launchwrapper']['path'].empty? }
  action :create_if_missing
end

include_recipe "minecraft::#{node['minecraft']['install_type']}"
include_recipe 'minecraft::service'

template "#{node['minecraft']['install_dir']}/server.properties" do
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  action :create
  notifies :restart, 'runit_service[minecraft]', :delayed if node['minecraft']['autorestart']
end

%w(ops banned-ips banned-players white-list).each do |f|
  file "#{node['minecraft']['install_dir']}/#{f}.txt" do
    owner node['minecraft']['user']
    group node['minecraft']['group']
    mode 0644
    action :create
    content node['minecraft'][f].join("\n") + "\n"
    notifies :restart, 'runit_service[minecraft]', :delayed if node['minecraft']['autorestart']
  end
end

file "#{node['minecraft']['install_dir']}/eula.txt" do
  content "eula=#{node['minecraft']['accept_eula']}\n"
  mode 0644
  action :create
  notifies :restart, 'runit_service[minecraft]', :delayed if node['minecraft']['autorestart']
end
