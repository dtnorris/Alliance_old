# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character do
    name "MyString"
    build_points 1
    experience_points 1
  end
end
