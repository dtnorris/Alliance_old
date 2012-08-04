# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_skill do
    skill_id 6
    character_id 1
    bought false
  end
end
