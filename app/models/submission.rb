class Submission < ActiveRecord::Base
  belongs_to :evaluation
  belongs_to :template
  has_many :answers


  accepts_nested_attributes_for :answers
end
