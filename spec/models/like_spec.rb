require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:post) {create(:post)}
  let(:comment) {create(:comment)}
  let(:liker) {create(:user)}

  context "when valid" do
    it "can like a Post" do
      valid_like = post.likes.new(user: liker)
      valid = valid_like.save
      expect(valid).to be true
    end

    it "shows in like list for Post" do
      valid_like = post.likes.create(user: liker)
      shows = post.likes.include?(valid_like)
      expect(shows).to be true
    end

    it "can like a Comment" do
      valid_like = comment.likes.new(user: liker)
      valid = valid_like.save
      expect(valid).to be true
    end

    it "shows in like list for Comment" do
      valid_like = comment.likes.create(user: liker)
      shows = comment.likes.include?(valid_like)
      expect(shows).to be true
    end

    it "can list likes by a User" do
      10.times do
        temp_comment = create(:comment)
        temp_comment.likes.create(user: liker)
      end
      num_likes = liker.likes.length
      expect(num_likes).to eq 10
    end

    it "can show who created the like" do
      valid_like = comment.likes.create(user: liker)
      user = valid_like.user
      expect(user).to be liker
    end

    it "can show which Post was liked" do
      valid_like = post.likes.create(user: liker)
      liked_post = valid_like.likeable
      expect(liked_post).to be post
    end

    it "can show which Comment was liked" do
      valid_like = comment.likes.create(user: liker)
      liked_comment = valid_like.likeable
      expect(liked_comment).to be comment
    end
  end


  context "when invalid" do
    it "can't like nothing" do
      no_target = Like.new(user: liker)
      valid = no_target.save
      expect(valid).to be false
    end

    it "can't like without a user" do
      no_user = comment.likes.create(user: nil)
      valid = no_user.save
      expect(valid).to be false
    end

    it "can't like the same thing multiple times" do
      comment.likes.create(user: liker)
      second_like = comment.likes.new(user: liker)
      valid = second_like.save
      expect(valid).to be false
    end
  end
end