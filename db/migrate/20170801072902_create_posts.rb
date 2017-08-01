class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
    	t.integer :author_id, index: true, foreign_key: true
    	t.text :content

      t.timestamps
    end
  end
end
