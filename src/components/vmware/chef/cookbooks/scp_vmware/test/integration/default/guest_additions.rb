describe file('C:\\Program Files\\VMware\\VMware Tools') do
  its('type') { should eq :directory }
  it { should be_directory }
end