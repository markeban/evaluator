class Template < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :template_teachers
  has_many :teachers, :through => :template_teachers



end
