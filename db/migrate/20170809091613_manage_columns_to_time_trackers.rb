class ManageColumnsToTimeTrackers < ActiveRecord::Migration[5.0]
  def change
    remove_column :time_trackers, :project_id, :integer
    add_column :time_trackers, :task_id, :integer
    add_column :time_trackers, :billable_date, :date
  end
end
