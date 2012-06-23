require 'spec_helper'

describe Character do
  it "should create a character_skill object when created" do
    CharacterSkill.all.count.should == 0
    Character.create
    CharacterSkill.all.count.should == 1
  end
end
