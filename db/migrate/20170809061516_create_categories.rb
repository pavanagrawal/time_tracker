class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string :name
      t.boolean :is_billable, default: true
      t.boolean :is_productive, default: true

      t.timestamps
    end
  end
end
