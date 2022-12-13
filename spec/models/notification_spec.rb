require 'rails_helper'

RSpec.describe Notification, type: :model do
  context "when valid" do
    let(:user) {User.create(
      id: 1,
      name: Faker::Name.name,
      username: Faker::Internet.unique.username,
      gender: "Male",
      birthday: Faker::Date.birthday(min_age: 10, max_age: 50),
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password(min_length: 10)
    )}
    let(:friend) {User.create(
      id: 2,
      name: Faker::Name.name,
      username: Faker::Internet.unique.username,
      gender: "Male",
      birthday: Faker::Date.birthday(min_age: 10, max_age: 50),
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password(min_length: 10)
    )}

    subject {user.notifications.new(
      text: "You have a notification about something!",
      link: "/"
    )}

    it "creates the notification" do
      valid = subject.save
      expect(valid).to be true
    end

    it "shows up in user's notifications" do
      shows = user.notifications.include?(subject)
      expect(shows).to be true
    end
  end

  context "when invalid" do
    it "doesn't save without a link" do
      no_link = Notification.new(
        text: "test",
        user_id: 1
      )
      valid = no_link.save
      expect(valid).to be false
    end

    it "doesn't save without text" do
      no_text = Notification.new(
        link: "users/index",
        user_id: 1
      )
      valid = no_text.save
      expect(valid).to be false
    end

    it "doesn't save without a user_id" do
      no_user = Notification.new(
        text: "test",
        link: "users/index"
      )
      valid = no_user.save
      expect(valid).to be false
    end
  end
end
