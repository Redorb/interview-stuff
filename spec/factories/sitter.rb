FactoryGirl.define do
  factory :sitter, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    avatar_url { Faker::Avatar.image }
    password { 'password' }
    password_confirmation { 'password' }
    roles_mask { Roles.roles_to_mask(['sitter', 'pet_owner']) }
  end

  factory :sitter_for_calc, class: User do
    first_name { 'abcdefghijk' }
    last_name { 'lm' }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    avatar_url { Faker::Avatar.image }
    password { 'password' }
    password_confirmation { 'password' }
    roles_mask { Roles.roles_to_mask(['sitter', 'pet_owner']) }
  end
end