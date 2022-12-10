require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should save with valid values" do
    user = User.new(name: "Aang", username: "100yearoldkid", email: "da_avatar@hawky.com", birthday: "1922-12-1", password: "earthwaterfireair", gender: "Male")
    # fails for some reason
    assert user.save, "Didn't save a user with valid values"
  end

  test "should not save without name" do
    user = User.new(username: "100yearoldkid", email: "da_avatar@hawky.com", birthday: "1922-12-1", password: "earthwaterfireair", gender: "Male")
    assert_not user.save, "Saved the User without a name"
  end

  test "name should not accept non-alphanumeric characters" do
    user = User.new(name: "A$^^^(&=", username: "100yearoldkid", email: "da_avatar@hawky.com", password: "earthwaterfireair", gender: "Male")
    assert_not user.save, "Accepted the User's name with invalid characters"
  end

  test "should not save without username" do
    user = User.new(name: "Aang", email: "da_avatar@hawky.com", birthday: "1922-12-1", password: "earthwaterfireair", gender: "Male")
    assert_not user.save, "Saved the User without a username"
  end

  test "should not accept duplicate username" do
    user = User.create(name: "Aang", username: "100yearoldkid", email: "da_avatar@hawky.com", birthday: "1922-12-1", password: "earthwaterfireair", gender: "Male")
    user_two = User.new(name: "Toph", username: "100yearoldkid", email: "greatest_earthbender_alive@hawky.com", birthday: "2012-12-1", password: "rocksrockingrock", gender: "Male")
    assert_not user_two.save, "Saved a User with duplicate username"
  end

  test "should not save without birthday" do
    user = User.new(name: "Aang", username: "100yearoldkid", email: "da_avatar@hawky.com", password: "earthwaterfireair", gender: "Male")
    assert_not user.save, "Saved the User without a birthday"
  end

  test "should not save a user younger than 18" do
    user = User.new(name: "Aang", username: "100yearoldkid", email: "da_avatar@hawky.com", birthday: "2020-12-1", password: "earthwaterfireair", gender: "Male")
    assert_not user.save, "Saved a user younger than 10"
  end

  test "should not save with unexpected gender" do
    user = User.new(name: "Aang", username: "100yearoldkid", email: "da_avatar@hawky.com", birthday: "1922-12-1", password: "earthwaterfireair", gender: "Pigeon")
    assert_not user.save, "Saved a user with gender of pigeon"
  end

  test "should not save with duplicate email" do
    user = User.create(name: "Aang", username: "100yearoldkid", email: "da_avatar@hawky.com", birthday: "1922-12-1", password: "earthwaterfireair", gender: "Male")
    user_two = User.new(name: "Toph", username: "toph_rocks", email: "da_avatar@hawky.com", birthday: "2012-12-1", password: "rocksrockingrock", gender: "Male")
    assert_not user_two.save, "Saved a User with duplicate username"
  end
end
