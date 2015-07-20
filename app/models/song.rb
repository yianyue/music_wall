class Song < ActiveRecord::Base
  validates :author, :title, presence: true
  validates :url, format: {with: URI::regexp}, if: Proc.new { |a| a.url.present? }
end