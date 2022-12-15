FactoryBot.define do
  factory :post do
    user { create(:user) }
    content { Faker::Quotes::Shakespeare.hamlet_quote }
  end
end
