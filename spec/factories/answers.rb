FactoryGirl.define do
  factory :answer do |f|
    f.sequence(:id) { |n| n }
    f.question_id 1
    f.submission_id 1
    f.answer "8"
    f.created_at "2014-04-18 03:23:30"
    f.updated_at "2014-04-18 03:23:30"
  end
end