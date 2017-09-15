FactoryGirl.define do
  factory :message do
    source 'sms'
    content { Faker::Lorem.sentence }
    msgHash '12knknfadsfdsf'
    sender_id nil
    conversation_id nil
  end
end