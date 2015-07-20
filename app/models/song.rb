class Song < ActiveRecord::Base

  belongs_to :user

  validates :author, :title, presence: true
  validates :url, format: {with: URI::regexp}, if: Proc.new { |a| a.url.present? }
  # QUESTION: how doe proc work???
  
end