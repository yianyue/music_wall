class User < ActiveRecord::Base

  has_many :songs
  has_many :upvotes
  has_many :reviews

  validates :email, format: {with: /\w+\.?\w+@\w+\.\w+/, message: "invalid"}, uniqueness: true
  validates :password, presence: true
  
end