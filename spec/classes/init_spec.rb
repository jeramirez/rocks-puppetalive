require 'spec_helper'
describe 'puppetalive' do

  context 'with defaults for all parameters' do
    it { should contain_class('puppetalive') }
  end
end
