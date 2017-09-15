FactoryGirl.define do
  factory :stay do
    text { Faker::Lorem.sentence }
    rating { 5 }
    start_date { Faker::Date.backward(23) }
    end_date { Faker::Date.forward(23) }
    sitter_id nil
    pet_owner_id nil
  end
end