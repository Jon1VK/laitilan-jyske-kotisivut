class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.string :league, null: false
      t.string :discipline, null: false
      t.string :athlete, null: false
      t.string :result, null: false
      t.string :location, null: false
      t.date :achieved_at, null: false

      t.timestamps
    end
    add_index :records, :league
    add_index :records, :discipline
  end
end
