class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_many_attached :images
  has_rich_text :content

  validates :content, presence: true
end