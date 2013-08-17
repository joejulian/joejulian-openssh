require 'spec_helper'

describe 'openssh::client' do
  let :param_hash do
    {
      'ensure' => 'latest',
      'source' => 'puppet:///modules/openssh/ssh_config',
    }
  end

  it { should contain_class('openssh::params') }

  context 'on Debian' do
    let :facts do
      {:osfamily => 'Debian'}
    end

    it do
      should contain_package('openssh-client').with(
        { 'ensure' => param_hash['ensure'] }
      ) 
      should contain_file('/etc/ssh/ssh_config').with( {
        'source' => param_hash['source'],
        'owner' => 'root',
        'mode' => '0644',
        'require' => 'Package[openssh-client]'
      } )
    end
  end

  context 'on RedHat' do
    let :facts do
      {:osfamily => 'RedHat'}
    end

    it do
      should contain_package('openssh-clients').with(
        { 'ensure' => param_hash['ensure'] }
      ) 
      should contain_file('/etc/ssh/ssh_config').with( {
        'source' => param_hash['source'],
        'owner' => 'root',
        'mode' => '0644',
        'require' => 'Package[openssh-clients]'
      } )
    end
  end
end
