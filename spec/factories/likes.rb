FactoryBot.define do
  factory :like do
    id { |n| n }
    user { create(:user) }
    likeable { create(:post) }
  end
end
