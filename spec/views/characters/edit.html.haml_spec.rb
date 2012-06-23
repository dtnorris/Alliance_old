require 'spec_helper'

describe "characters/edit" do
  before(:each) do
    @character = assign(:character, stub_model(Character,
      :name => "MyString",
      :build_points => 1,
      :experience_points => 1
    ))
  end

  it "renders the edit character form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => characters_path(@character), :method => "post" do
      assert_select "input#character_name", :name => "character[name]"
      assert_select "input#character_build_points", :name => "character[build_points]"
      assert_select "input#character_experience_points", :name => "character[experience_points]"
    end
  end
end
