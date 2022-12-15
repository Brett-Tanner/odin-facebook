class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :likeable_id, :likeable_type, presence: true
  validates :user_id, uniqueness: {scope: [:likeable_id, :likeable_type], message: "Users can only like a post/comment once"}
end