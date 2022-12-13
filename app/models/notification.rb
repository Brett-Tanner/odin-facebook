class Notification < ApplicationRecord
  belongs_to :user

  validates :link, :text, :user_id, presence: true
end
