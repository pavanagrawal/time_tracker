class CreateAllocations < ActiveRecord::Migration[5.0]
  def change
    create_table :allocations do |t|
      t.integer :project_id
      t.integer :user_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
