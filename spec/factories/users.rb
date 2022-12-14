FactoryBot.define do
  factory :user do
    id { 1 }
    name { Faker::Name.name }
    username { Faker::Internet.unique.username }
    gender { "Male" }
    birthday { Faker::Date.birthday(min_age: 10, max_age: 50) }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 10) }
  end
end