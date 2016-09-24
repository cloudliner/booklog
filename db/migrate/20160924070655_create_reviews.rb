class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :isbn
      t.string :title
      t.string :auther
      t.string :review

      t.timestamps null: false
    end
  end
end
