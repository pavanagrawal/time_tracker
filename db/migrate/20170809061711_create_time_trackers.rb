class CreateTimeTrackers < ActiveRecord::Migration[5.0]
  def change
    create_table :time_trackers do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :category_id
      t.integer :time_consumed

      t.timestamps
    end
  end
end
