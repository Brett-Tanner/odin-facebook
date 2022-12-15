FactoryBot.define do
  factory :comment do
    id {|n| n}
    body { Faker::Quotes::Shakespeare.romeo_and_juliet_quote }
    commentable { create(:post) }
    user { create(:user) }
  end
end
