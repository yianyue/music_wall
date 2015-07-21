class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :song

  validates :content, presence: true
  
end