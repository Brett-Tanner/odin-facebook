require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) {create(:user)}

  context "when valid" do
    it "saves" do
      valid_post = user.posts.new(content: "This is test content")
      valid = valid_post.save
      expect(valid).to be true
    end

    it "shows in User post list" do
      valid_post = user.posts.create(content: "This is test content")
      shows = user.posts.include?(valid_post)
      expect(shows).to be true
    end
  end

  context "when invalid" do
    it "doesn't save without User" do
      no_user = Post.new(content: "This is test content")
      valid = no_user.save
      expect(valid).to be false
    end

    it "doesn't save without content" do
      no_content = user.posts.new
      valid = no_content.save
      expect(valid).to be false
    end
  end
end
