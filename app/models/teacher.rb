class Teacher < ActiveRecord::Base
  has_many :template_teachers
  has_many :templates, :through => :template_teachers
end
