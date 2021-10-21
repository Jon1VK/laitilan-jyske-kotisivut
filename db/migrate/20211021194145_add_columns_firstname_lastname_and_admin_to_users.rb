class AddColumnsFirstnameLastnameAndAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string, null: false
    add_column :users, :lastname, :string, null: false
    add_column :users, :admin, :boolean, default: false
  end
end
