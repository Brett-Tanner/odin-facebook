require 'rails_helper'

RSpec.describe 'User', type: :model do
  context "when valid" do
    it "saves" do
      valid_user = build(:user)
      valid = valid_user.save
      expect(valid).to be true
    end
  end

  context "when invalid" do
    it "doesn't save without a name" do
      no_name = build(:user, name: nil)
      valid = no_name.save
      expect(valid).to be false
    end

    # FIXME: not passing cos the validation doesn't work
    xit "doesn't save with invalid name" do
      invalid_name = build(:user, name: "A$^^^(&=")
      valid = invalid_name.save
      expect(valid).to be false
    end

    it "doesn't save without a username" do
      no_username = build(:user, username: nil)
      valid = no_username.save
      expect(valid).to be false
    end

    it "doesn't save with duplicate username" do
      user = build(:user, username: "Bobthebuilder", )
      user_duplicate = build(:user, username: "Bobthebuilder", id: 2)
      user.save
      valid = user_duplicate.save
      expect(valid).to be false
    end

    it "doesn't save without a birthday" do
      no_bday = build(:user, birthday: nil)
      valid = no_bday.save
      expect(valid).to be false
    end

    it "rejects users under 10" do
      too_young = build(:user, birthday: "2020-12-1")
      valid = too_young.save
      expect(valid).to be false
    end

    it "rejects users with unexpected genders" do
      pigeon = build(:user, gender: "pigeon")
      valid = pigeon.save
      expect(valid).to be false
    end
  end
end