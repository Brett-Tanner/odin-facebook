require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) {create(:post)}
  let(:comment) {create(:comment)}
  let(:commenter) {create(:user)}

  context "when valid" do
    it "can comment on Post" do
      valid_comment = post.comments.new(body: Faker::Quotes::Shakespeare.hamlet_quote, user: commenter)
      valid = valid_comment.save
      expect(valid).to be true
    end

    it "is listed in Post's comments" do
      valid_comment = post.comments.create(body: Faker::Quotes::Shakespeare.hamlet_quote, user: commenter)
      listed = post.comments.include?(valid_comment)
      expect(listed).to be true
    end

    it "can comment on Comment" do
      valid_comment = comment.comments.new(body: Faker::Quotes::Shakespeare.hamlet_quote, user: create(:user))
      valid = valid_comment.save
      expect(valid).to be true
    end

    it "is listed in Comment's comments" do
      valid_comment = comment.comments.create(body: Faker::Quotes::Shakespeare.hamlet_quote, user: create(:user))
      listed = comment.comments.include?(valid_comment)
      expect(listed).to be true
    end

    it "can comment on same thing multiple times" do
      10.times do
        comment.comments.create(body: Faker::Quotes::Shakespeare.hamlet_quote, user: create(:user))
      end
      comment_count = comment.comments.length
      expect(comment_count).to eq 10
    end

    it "can list comments from a user" do
      10.times do
        comment.comments.create(body: Faker::Quotes::Shakespeare.hamlet_quote, user: commenter)
      end
      num_comments = commenter.comments.length
      expect(num_comments).to eq 10
    end
  end

  context "when invalid" do
    it "won't save without something to comment on" do
      no_parent = build(:comment, commentable: nil)
      valid = no_parent.save
      expect(valid).to be false
    end

    it "won't save without a body" do
      no_body = build(:comment, body: nil)
      valid = no_body.save
      expect(valid).to be false
    end
  end
end
