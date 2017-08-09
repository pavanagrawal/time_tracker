FactoryGirl.define do
  factory :time_tracker do
    user_id 1
    project_id 1
    category_id 1
    time_consumed 1
    is_holiday false
    is_leave false
  end
end
