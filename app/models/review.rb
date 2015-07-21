class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :song

  validates :content, presence: true
  validates :user_id, uniqueness: { scope: :song_id, message: 'You can only review a song once' }

  
end