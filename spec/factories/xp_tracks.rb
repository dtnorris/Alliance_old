# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :xp_track do
    character_id 1
    start_xp 1
    end_xp 1
    reason "MyString"
  end
end
