class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.text :comment, null: false
      # t.integer :status, null: false, defaile: 0

      t.timestamps
    end
  end
end