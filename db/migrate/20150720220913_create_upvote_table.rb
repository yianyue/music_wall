class CreateUpvoteTable < ActiveRecord::Migration
  def change
    create_join_table :users, :songs, table_name: :upvotes
  end
end
