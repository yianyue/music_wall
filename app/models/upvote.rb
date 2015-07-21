class Upvote < ActiveRecord::Base

  belongs_to :user
  belongs_to :song, counter_cache: true

  validates :user_id, uniqueness: { scope: :song_id, message: 'You can only upvote a song once' }

end