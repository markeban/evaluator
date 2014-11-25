class Evaluation < ActiveRecord::Base
  belongs_to :template
  belongs_to :teacher
  has_many :submissions


  
end
