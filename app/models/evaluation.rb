class Evaluation < ActiveRecord::Base
  belongs_to :template
  belongs_to :teacher
end
