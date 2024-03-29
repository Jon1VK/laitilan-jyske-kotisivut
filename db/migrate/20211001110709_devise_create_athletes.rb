# frozen_string_literal: true

class DeviseCreateAthletes < ActiveRecord::Migration[6.1]
  def change
    create_table :athletes do |t|
      t.string :slug, null: false

      t.string :firstname, null: false
      t.string :lastname, null: false

      t.string :event

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :athletes, :email,                unique: true
    add_index :athletes, :reset_password_token, unique: true
    add_index :athletes, :slug,                 unique: true
  end
end
