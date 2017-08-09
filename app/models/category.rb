# create_table "categories", force: :cascade do |t|
#   t.integer  "parent_id"
#   t.string   "name"
#   t.boolean  "is_billable",   default: true
#   t.boolean  "is_productive", default: true
#   t.datetime "created_at",                   null: false
#   t.datetime "updated_at",                   null: false
# end

class Category < ApplicationRecord


  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent_id'
  scope :leaf_nodes, -> {where('parent_id IS NOT NULL')}
  scope :parent_nodes, -> {where('parent_id IS NULL')}

  has_many :time_trackers

  validates :name, presence: true

end
