#
# Cookbook Name:: minecraft
# Attributes:: default
#
# Copyright 2013, Greg Fitzgerald.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['minecraft']['user']                = 'mcserver'
default['minecraft']['group']               = 'mcserver'
default['minecraft']['install_dir']         = '/srv/minecraft'
# Currently vanilla, bukkit, spigot, ftb
default['minecraft']['install_type']        = 'vanilla'

default['java']['install_flavor']           = 'default'

puts "\n\n#{node['minecraft']['install_type']}\n\n"

default['minecraft']['vanilla']['url']          = 'https://s3.amazonaws.com/Minecraft.Download/versions/1.8.7/minecraft_server.1.8.7.jar'
default['minecraft']['vanilla']['checksum']     = '5cf4a49762c996c94f6b8b119f1c80b4de3c12b2f5c53268801905bb7daa0644'
default['minecraft']['vanilla']['server_opts']  = 'nogui'
default['minecraft']['vanilla']['java-options'] = ''
default['minecraft']['vanilla']['launchwrapper']['path']      = ''
default['minecraft']['vanilla']['launchwrapper']['checksum']  = ''

default['minecraft']['bukkit']['url']           = 'http://dl.bukkit.org/downloads/craftbukkit/get/02389_1.6.4-R2.0/craftbukkit.jar'
default['minecraft']['bukkit']['checksum']      = '29c26ec69dcaf8c1214f90f5fa5609fc451aae5fe0d22fd4ce37a505684545b3'
default['minecraft']['bukkit']['server_opts']   = '--noconsole --online-mode true'
default['minecraft']['bukkit']['java-options']  = ''
default['minecraft']['bukkit']['launchwrapper']['path']      = ''
default['minecraft']['bukkit']['launchwrapper']['checksum']  = ''

default['minecraft']['spigot']['url']           = 'http://ci.md-5.net/view/Spigot/job/Spigot/lastStableBuild/artifact/Spigot-Server/target/spigot.jar'
default['minecraft']['spigot']['checksum']      = '13abb884cb8f1bc8dfcd110fa3616f03b7ec5e23eb4b2e903b054c0ad23c4ac5'
default['minecraft']['spigot']['server_opts']   = ''
default['minecraft']['spigot']['launchwrapper']['path']      = ''
default['minecraft']['spigot']['launchwrapper']['checksum']  = ''

default['minecraft']['ftb']['url']              = 'https://s3.amazonaws.com/Minecraft.Download/versions/1.7.10/minecraft_server.1.7.10.jar'
default['minecraft']['ftb']['checksum']         = 'c70870f00c4024d829e154f7e5f4e885b02dd87991726a3308d81f513972f3fc'
default['minecraft']['ftb']['jarfile']          = 'FTBServer-1.7.10-1558.jar'
default['minecraft']['ftb']['ftb_url']          = 'http://ftb.cursecdn.com/FTB2/modpacks/FTBInfinity/2_3_5/FTBInfinityServer.zip'
default['minecraft']['ftb']['ftb_checksum']     = '04360da392bcaa8de5768eee4918825606deb5a053bd9c904a752928d08fc5ff'
default['minecraft']['ftb']['java-options']     = '-XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10'
default['minecraft']['ftb']['server_opts']      = 'nogui'
default['minecraft']['ftb']['launchwrapper']['path']      = 'net/minecraft/launchwrapper/1.12/launchwrapper-1.12.jar'
default['minecraft']['ftb']['launchwrapper']['checksum']  = '57f402b626d16cc2705bf2a37add7adbb074f0ca3b3102fa6e23aa303dae682f'

# Defaults to 40% of your total memory.
default['minecraft']['xms']                 = "#{(node['memory']['total'].to_i * 0.4).floor / 1024}M"
# Defaults to 60% of your total memory.
default['minecraft']['xmx']                 = "#{(node['memory']['total'].to_i * 0.6).floor / 1024}M"

default['minecraft']['init_style']          = 'runit'

default['minecraft']['ops']                 = []
default['minecraft']['banned-ips']          = []
default['minecraft']['banned-players']      = []
default['minecraft']['white-list']          = []

# Stop minecraft from binding to ipv6 by default
default['minecraft']['prefer_ipv4']         = true

# See the readme for an explanation
default['minecraft']['autorestart']         = true

default['minecraft']['java-options']        = nil

