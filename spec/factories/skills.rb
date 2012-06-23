# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill do
    name "MyString"
    fighter_cost 1
    scout_cost 1
    rogue_cost 1
    adept_cost 1
    scholar_cost 1
    templar_cost 1
    artisan_cost 1
  end
end
