FactoryGirl.define do
  factory :template do |f|
    f.id 1
    f.name "Template Test Name"
    f.created_at "2014-04-18 02:23:30"
    f.updated_at "2014-04-18 02:23:30"
    f.user_id 1
    f.description "This is the description name of the test template"
  end
end