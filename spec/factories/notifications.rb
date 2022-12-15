FactoryBot.define do
  factory :notification do
    id { |n| n }
    text { "MyString" }
    link { "MyString" }
    user { create(:user) }
  end
end
