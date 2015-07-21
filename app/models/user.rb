class User < ActiveRecord::Base

  has_many :songs
  has_many :upvotes

  validates :email, format: {with: /\w+\.?\w+@\w+\.\w+/, message: "invalid email"}, uniqueness: true
  validates :password, presence: true
  
end