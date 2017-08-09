class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :project_id
      t.text :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
