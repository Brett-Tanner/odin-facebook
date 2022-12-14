class User < ApplicationRecord
  has_many :notifications
  has_many :posts

  # Friendship associations
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :received_friendships, class_name: 'Friendship', 
                                  foreign_key: 'friend_id'
  has_many :received_friends, through: :received_friendships, 
                              source: 'user'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :trackable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, :username, :birthday, presence: true
  validates :username, uniqueness: true
  validates :gender, inclusion: {in: ["Male", "Female", "Prefer not to say"]}
  validates :birthday, comparison: {less_than: Date.today - 10.years}

  def active_friends
    friends.select{ |friend| friend.friends.include?(self) }  
  end
  
  def pending_friends
    friends.select{ |friend| !friend.friends.include?(self) }  
  end
end
