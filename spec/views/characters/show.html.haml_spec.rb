require 'spec_helper'

describe "characters/show" do
  before(:each) do
    @character = assign(:character, stub_model(Character,
      :name => "Name",
      :race => "Human",
      :build_points => 1,
      :experience_points => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Human/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
