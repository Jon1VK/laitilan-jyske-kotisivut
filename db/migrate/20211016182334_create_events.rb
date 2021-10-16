class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :location, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.text :description, null: false
      t.string :registration_url
      t.datetime :registration_due

      t.timestamps
    end
    add_index :events, [:title, :start_time], unique: true
  end
end
