require 'rails_helper'

RSpec.describe 'User' do
  context "when valid" do
    it "saves" do
      valid_user = User.new(
        name: "Aang",
        username: "100yearoldkid",
        email: "da_avatar@hawky.com",
        birthday: "1922-12-1",
        password: "earthwaterfireair",
        gender: "Male")
      valid = valid_user.save
      expect(valid).to be true
    end
  end

  context "when invalid" do
    it "doesn't save without a name" do
      no_name = User.new(
        username: "100yearoldkid",
        email: "da_avatar@hawky.com",
        birthday: "1922-12-1",
        password: "earthwaterfireair",
        gender: "Male")
      valid = no_name.save
      expect(valid).to be false
    end

    it "doesn't save with invalid name" do
      invalid_name = User.new(
        name: "A$^^^(&=",
        username: "100yearoldkid",
        email: "da_avatar@hawky.com",
        password: "earthwaterfireair",
        gender: "Male")
      valid = invalid_name.save
      expect(valid).to be false
    end

    it "doesn't save without a username" do
      no_username = User.new(
        name: "Aang",
        email: "da_avatar@hawky.com",
        birthday: "1922-12-1",
        password: "earthwaterfireair",
        gender: "Male")
      valid = no_username.save
      expect(valid).to be false
    end

    it "doesn't save with duplicate username" do
      user = User.new(
        name: "Aang",
        username: "100yearoldkid",
        email: "da_avatar@hawky.com",
        birthday: "1922-12-1",
        password: "earthwaterfireair",
        gender: "Male")
        
      user_duplicate = User.new(
        name: "Toph",
        username: "100yearoldkid",
        email: "greatest_earthbender_alive@hawky.com",
        birthday: "2012-12-1",
        password: "rocksrockingrock",
        gender: "Male")
      user.save
      valid = user_duplicate.save
      expect(valid).to be false
    end

    it "doesn't save without a birthday" do
      no_bday = User.new(
        name: "Aang",
        username: "100yearoldkid",
        email: "da_avatar@hawky.com",
        password: "earthwaterfireair",
        gender: "Male")
      valid = no_bday.save
      expect(valid).to be false
    end

    it "rejects users under 10" do
      too_young = User.new(
        name: "Aang",
        username: "100yearoldkid",
        email: "da_avatar@hawky.com",
        birthday: "2020-12-1",
        password: "earthwaterfireair",
        gender: "Male")
      valid = too_young.save
      expect(valid).to be false
    end

    it "rejects users with unexpected genders" do
      pigeon = User.new(
        name: "Aang",
        username: "100yearoldkid",
        email: "da_avatar@hawky.com",
        birthday: "1922-12-1",
        password: "earthwaterfireair",
        gender: "Pigeon")
      valid = pigeon.save
      expect(valid).to be false
    end
  end
end