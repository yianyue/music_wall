class AddVotesCount < ActiveRecord::Migration
  def change
     add_column :songs, :upvotes_count, :integer, :default => 0

    Song.reset_column_information

    Song.all.each do |p|
      Song.update_counters p.id, :upvotes_count => p.upvotes.length
    end

  end
end
