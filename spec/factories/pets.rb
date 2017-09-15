FactoryGirl.define do
  factory :pet do
    name { Faker::Name.name }
    owner_id nil
  end
end