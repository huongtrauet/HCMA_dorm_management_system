class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.longtext :content
      t.string :writer_name
      t.references :manager, null: false, foreign_key: true

      t.timestamps
    end
  end
end
