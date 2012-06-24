# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_class do
    name "MyString"
    build_per_body "MyString"
    armor_limit "MyString"
  end
end
