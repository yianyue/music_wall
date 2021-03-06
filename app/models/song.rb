class Song < ActiveRecord::Base

  belongs_to :user
  has_many :upvotes
  has_many :reviews

  validates :title, presence: true
  validates :url, format: {with: URI::regexp}, if: Proc.new { |a| a.url.present? }
  # QUESTION: how doe proc work???

  before_create :remove_empty_string

  private

  def remove_empty_string
    self.url = nil if self.url.empty?
  end
  
end