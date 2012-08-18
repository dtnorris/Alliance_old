require 'spec_helper'

describe 'Assignment' do
  it 'should be able to import player users' do
    a = Assignment.data_import 1
    a.user.id.should == 1
    a.role.id.should == 1
  end
end
