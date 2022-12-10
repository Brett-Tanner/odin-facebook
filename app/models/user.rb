class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :trackable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, :username, :birthday, presence: true
  validates :username, uniqueness: true
  validates :gender, inclusion: {in: ["Male", "Female", "Prefer not to say"]}
  validates :birthday, comparison: {less_than: Date.today - 10.years}
end
