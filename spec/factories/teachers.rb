FactoryGirl.define do
  factory :teacher do |f|
    f.id 1
    f.name "Jane Doe"
    f.email "janedoe@gmail.com"
    f.created_at "2014-04-18 03:23:30"
    f.updated_at "2014-04-18 03:23:30"
    f.user_id 1
  end
end