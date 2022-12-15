FactoryBot.define do
  factory :friendship do
    id { |n| n }
    user { create(:user) }
    friend { create(:user) }
  end
end