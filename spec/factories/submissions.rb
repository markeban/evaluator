FactoryGirl.define do
  factory :submission do |f|
    f.sequence(:id) { |n| n } 
    f.evaluation_id 1
    f.created_at "2014-04-18 03:23:30"
    f.updated_at "2014-04-18 03:23:30"
  end
end