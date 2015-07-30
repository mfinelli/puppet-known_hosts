require 'spec_helper'
describe 'known_hosts' do

  context 'with defaults for all parameters' do
    it { should contain_class('known_hosts') }
  end
end
