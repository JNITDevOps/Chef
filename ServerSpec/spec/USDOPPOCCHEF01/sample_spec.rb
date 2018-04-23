require 'spec_helper'

describe host('serverspec.org') do
  it { should be_resolvable }
end

# ping serverspec.org
describe host('serverspec.org') do
  it { should be_reachable }
end

describe interface('eno16777984') do
  it { should exist }
end

#ifconfig
describe interface('eno16777984') do
  it { should have_ipv4_address("172.16.100.236") }
  it { should have_ipv4_address("172.16.100.236/24") }
end

#ls /etc/passwd -hal
describe file('/etc/passwd') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'root' }
  it { should contain 'root' }
  it { should be_mode 644 }
end

#ls -hal
describe file('/tmp') do
  it { should be_directory }
end

#getent groups |grep root
describe group('root') do
  it { should exist }
end

#rpm -qa|grep python-backports-1.0-8.el7.x86_64
describe package('python-backports-1.0-8.el7.x86_64') do
  it { should be_installed }
end

# ps aux|grep rcu_sched
describe process('rcu_sched') do
  its(:user) { should eq "root" }
  its(:stat) { should eq "R" }
end

#systemctl |grep postfix
describe service('postfix') do
  it { should be_enabled }
  it { should be_running }
end

#netstat -plnt
describe port(22) do
  it { should be_listening.with('tcp') }
end

#netstat |grep socket
describe file"/run/systemd/journal/socket" do
  it { should be_socket }
end

#sysctl -a
describe 'Linux kernel parameters' do
  context linux_kernel_parameter('kernel.hostname') do
    its(:value) { should eq "USDOPPOCCHEF01" }
  end

  context linux_kernel_parameter('kernel.osrelease') do
    its(:value) { should eq "3.10.0-327.el7.x86_64" }
  end

  context linux_kernel_parameter('kernel.ostype') do
    its(:value) { should eq "Linux" }
  end
end

#id
describe user"root" do
  it { should exist }
  it { should have_home_directory "/root" }
end

describe command"id -nu" do
  its(:stdout) { should match "root" }
end
