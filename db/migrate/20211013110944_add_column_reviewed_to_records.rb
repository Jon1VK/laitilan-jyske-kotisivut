class AddColumnReviewedToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :reviewed, :boolean, default: true
  end
end
