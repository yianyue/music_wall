class User < ActiveRecord::Base

  has_many :songs

  validates :email, format: {with: /\w+\.?\w+@\w+\.\w+/, message: "invalid email"}, uniqueness: true
  validates :password, presence: true
  
end