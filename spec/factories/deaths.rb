# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :death do
    character_id 1
    chapter_id 1
    regen_css false
    buyback false
  end
end
