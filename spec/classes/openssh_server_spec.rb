require 'spec_helper'

describe 'openssh::server' do
  let :param_hash do
    {
      'ensure' => 'latest',
      'source' => 'puppet:///modules/openssh/sshd_config',
    }
  end

  it do
    should contain_class('openssh::params') 

    should contain_package('openssh-server').with(
      { 'ensure' => param_hash['ensure'] }
    )

    should contain_file('/etc/ssh/sshd_config').with( {
      'source' => param_hash['source'],
      'owner' => 'root',
      'mode' => '0600',
      'require' => 'Package[openssh-server]',
      'notify' => 'Service[sshd]'
    } )

    should contain_service('sshd').with( {
      'ensure' => 'running',
      'enable' => 'true',
      'require' => 'Package[openssh-server]'
    } )
  end

  context 'on Debian' do
    let :facts do
      {:osfamily => 'Debian'}
    end
  end

  context 'on RedHat' do
    let :facts do
      {:osfamily => 'RedHat'}
    end
  end

  #TODO: When supported, add tests for exported resources
end
