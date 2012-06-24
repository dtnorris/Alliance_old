require 'spec_helper'

describe CharacterSkill do

  it "can filter database columns not to display" do
    char = CharacterSkill.create
    arr = [true]
    char.attributes.each {|atn, atv| arr << CharacterSkill.display_val(atn)}
    arr.map {|e| e if !e}.compact.count.should == 3
  end

end
