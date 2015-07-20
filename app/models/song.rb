class Song < ActiveRecord::Base

  belongs_to :user

  validates :author, :title, presence: true
  validates :url, format: {with: URI::regexp}, if: Proc.new { |a| a.url.present? }
  # QUESTION: how doe proc work???

  before_save :remove_empty_string

  private

  def remove_empty_string
    self.url = nil if self.url.empty?
  end
  
end