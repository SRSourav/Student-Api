FactoryGirl.define do
  factory :student do
    full_name { Faker::Lorem.word }
    roll { Faker::Number.number(10) }
  end
end