# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :patron_xp do
    character_id 1
    event_id 1
    user_id 1
    applied false
  end
end
