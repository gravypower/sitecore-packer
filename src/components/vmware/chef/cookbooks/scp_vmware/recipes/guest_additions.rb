scp_virtualbox_guest_additions '' do
  guest_additions_options node['scp_vmware']['guest_additions']
  action :install
end
