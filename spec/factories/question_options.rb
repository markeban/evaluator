FactoryGirl.define do
  factory :question_option do |f|
    f.sequence(:id) { |n| n }
    f.sequence(:text) { |q| "QuestionOption#{q}" }
    f.question_id 4
    f.created_at "2014-04-18 03:23:30"
    f.updated_at "2014-04-18 03:23:30"
  end

end