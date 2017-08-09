# create_table "projects", force: :cascade do |t|
#   t.string "name"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

class Project < ApplicationRecord
  has_many :allocations
  validates :name, presence: true
end
