tmp_file = '/tmp/ftb.zip'

remote_file tmp_file do
  source node['minecraft']['ftb']['ftb_url']
  checksum node['minecraft']['ftb']['ftb_checksum']
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  not_if { File.exist?("#{node['minecraft']['install_dir']}/#{node['minecraft']['ftb']['jarfile']}") }
end

package 'unzip'
execute 'UnzipFTB' do
  command "unzip -o #{tmp_file}"
  cwd node['minecraft']['install_dir']
  user node['minecraft']['user']
  group node['minecraft']['group']
  not_if { File.exist? "#{node['minecraft']['install_dir']}/#{node['minecraft']['ftb']['jarfile']}" }
end

