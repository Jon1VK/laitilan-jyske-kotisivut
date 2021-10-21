class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :slug, null: false
      t.string :title, null: false
      t.date :published_at, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :news, :slug, unique: true
  end
end
