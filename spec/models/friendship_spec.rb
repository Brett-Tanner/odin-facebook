require 'rails_helper'
require 'faker'

RSpec.describe 'Friendship', type: :model do

  let(:user) {User.create(
    name: Faker::Name.name,
    username: Faker::Internet.unique.username,
    gender: "Male",
    birthday: Faker::Date.birthday(min_age: 10, max_age: 50),
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 10)
  )}
  let(:friend) {User.create(
    name: Faker::Name.name,
    username: Faker::Internet.unique.username,
    gender: "Male",
    birthday: Faker::Date.birthday(min_age: 10, max_age: 50),
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 10)
  )}

  context "when valid" do
    it "makes a request" do
      valid_request = user.friendships.new(friend_id: friend.id)
      valid = valid_request.save
      expect(valid).to be true
    end

    it "accepts the request" do
      user.friendships.create(friend_id: friend.id)
      response = friend.friendships.create(friend_id: user.id)
      mutual = response.is_mutual?
      expect(mutual).to be true
    end
  end

  context "while request is pending" do

    before do
      user.friendships.create(friend_id: friend.id)
    end

    it "shows pending requests" do
      requests = user.pending_friends
      expect(requests).to include(friend)
    end

    it "doesn't show requested friend as active" do
      user_friends = user.active_friends
      expect(user_friends).not_to include(friend)
    end

    it "doesn't show friendship is mutual" do
      friendship = user.friendships.first
      mutual = friendship.is_mutual?
      expect(mutual).to be false
    end

    it "shows users who requested friendship" do
      received = friend.received_friends
      expect(received).to include(user)
    end
  end
  
  context "after request is accepted" do

    before do
      user.friendships.create(friend_id: friend.id)
      friend.friendships.create(friend_id: user.id)
    end

    it "shows active friends" do
      user_friends = user.active_friends
      expect(user_friends).to include(friend)
    end

    it "shows friendship is mutual" do
      friendship = user.friendships.first
      mutual = friendship.is_mutual?
      expect(mutual).to be true
    end
  end

  context "when invalid" do
    it "can't add self as friend" do
      add_self = user.friendships.create(friend_id: user.id)
      error = add_self.errors.first.message
      expect(error).to eq "Can't be the same as the user"
    end

    it "can't become friends if already friends" do
      user.friendships.create(friend_id: friend.id)
      friend.friendships.create(friend_id: user.id)
      double = user.friendships.create(friend_id: friend.id)
      error = double.errors.first.message
      expect(error).to eq "Already friends with this user"
    end

    it "can't become friends with non-existent user" do
      add_no_one = user.friendships.new(friend_id: User.last.id + 1)
      saved = add_no_one.save
      expect(saved).to be false
    end

    it "can't create friendship without a friend" do
      add_no_one = user.friendships.new
      saved = add_no_one.save
      expect(saved).to be false
    end
  end
end