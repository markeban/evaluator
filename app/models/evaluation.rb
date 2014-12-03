class Evaluation < ActiveRecord::Base
  belongs_to :template
  belongs_to :teacher
  has_many :submissions
  has_many :answers, :through => :submissions


  
end
