# create_table "allocations", force: :cascade do |t|
#   t.integer  "project_id"
#   t.integer  "user_id"
#   t.date     "start_date"
#   t.date     "end_date"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

class Allocation < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
