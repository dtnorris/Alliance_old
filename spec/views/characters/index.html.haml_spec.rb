require 'spec_helper'

describe "characters/index" do
  before(:each) do
    assign(:characters, [
      stub_model(Character,
        :name => "Name",
        :build_points => 1,
        :experience_points => 2,
        :race_id => 11,
        :character_class_id => 1
      ),
      stub_model(Character,
        :name => "Name",
        :build_points => 1,
        :experience_points => 2,
        :race_id => 11,
        :character_class_id => 1
      )
    ])
  end

  it "renders a list of characters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => Race.find_by_id(11).name.to_s, :count => 2
    assert_select "tr>td", :text => CharacterClass.find_by_id(1).name.to_s, :count => 2
  end
end
