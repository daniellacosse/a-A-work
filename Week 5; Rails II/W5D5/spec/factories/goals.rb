# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    name "example_goal"
    description "My example goal is fantastic!"
    completed? false
    private? false
  end
end

#
# t.string   "name"
# t.text     "description"
# t.boolean  "completed?",  default: false
# t.integer  "user_id"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.boolean  "private?",    default: false