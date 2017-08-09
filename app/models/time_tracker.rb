# create_table "time_trackers", force: :cascade do |t|
#   t.integer  "user_id"
#   t.integer  "project_id"
#   t.integer  "category_id"
#   t.integer  "time_consumed"
#   t.datetime "created_at",    null: false
#   t.datetime "updated_at",    null: false
# end

class TimeTracker < ApplicationRecord

  belongs_to :category
  belongs_to :project

end
