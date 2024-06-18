FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    email_verified_at { Time.now }
    password { 'password' }

    trait :unverified do
      email_verified_at { nil }
    end
  end
end
