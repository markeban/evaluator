FactoryGirl.define do
  factory :question do |f|
    f.sequence(:id) { |n| n }
    f.sequence(:text) { |q| "Question#{q}" }
    f.template_id 1
    f.required 0
    f.format_type "scale1To10"
    f.created_at "2014-04-18 03:23:30"
    f.updated_at "2014-04-18 03:23:30"
  end

end