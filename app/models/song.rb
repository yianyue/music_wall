class Song < ActiveRecord::Base

  belongs_to :user
  has_many :upvotes

  validates :title, presence: true
  validates :url, format: {with: URI::regexp}, if: Proc.new { |a| a.url.present? }
  # QUESTION: how doe proc work???

  before_create :remove_empty_string

  def votes
    self.upvotes.size
  end

  private

  def remove_empty_string
    self.url = nil if self.url.empty?
  end
  
end