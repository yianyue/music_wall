class DropAuthorFromSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :author, :string
  end
end
