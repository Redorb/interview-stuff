FactoryGirl.define do
  factory :pet_owner, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    avatar_url { Faker::Avatar.image }
    password { 'password' }
    password_confirmation { 'password' }
    roles_mask { Roles.roles_to_mask(['pet_owner']) }
  end
end