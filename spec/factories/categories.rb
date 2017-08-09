FactoryGirl.define do
  factory :category do
    parent_id 1
    name "MyString"
    is_billable false
    is_productive false
  end
end
