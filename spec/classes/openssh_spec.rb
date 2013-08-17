require 'spec_helper'

describe 'openssh' do
      it { should include_class('openssh::params') }
end
