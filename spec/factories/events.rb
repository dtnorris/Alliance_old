# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    chapter_id 1
    xp_value 1
    date "2012-07-18"
    name "MyString"
  end
end
