class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :song, index: true
      t.references :user, index: true
      t.text :content
      t.timestamps null:false
    end
  end
end
