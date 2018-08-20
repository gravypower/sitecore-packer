property :guest_additions_options, Hash, required: true

default_action :install

action :install do
  directory_path = "#{Chef::Config[:file_cache_path]}/scp_vmware/guest_additions"

  directory directory_path do
    recursive true
    action :create
  end

  guest_additions_version = new_resource.guest_additions_options['version']
  guest_additions_build = new_resource.guest_additions_options['build']
  tools_file_name = "VMware-tools-#{guest_additions_version}-#{guest_additions_build}-x86_64.exe"
  tools_file_source_url = "https://packages.vmware.com/tools/releases/#{guest_additions_version}/windows/x64/#{tools_file_name}"

  remote_file "#{directory_path}/VMware-tools.exe" do
    source iso_file_source_url
    action :create
  end

  package 'VMware Tools' do
    source "#{directory_path}/VMware-tools.exe"
    installer_type :custom
    options  '/s /v"/qn REBOOT=R"'
    returns [0,1618,1641,3010]
    action :install
  end

  directory directory_path do
    recursive true
    action :delete
  end
end
