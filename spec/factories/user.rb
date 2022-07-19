FactoryBot.define do
  factory(:user) do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :admin do
      role { 0 }
    end
  end
end
