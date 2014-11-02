class FormQuestion < ActiveRecord::Base
  belongs_to :form
  has_many :form_answers
  
end
