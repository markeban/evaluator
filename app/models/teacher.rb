class Teacher < ActiveRecord::Base
  has_many :template_teachers
  has_many :templates, :through => :template_teachers
  has_many :evaluations

  def full_name
    "#{first_name} #{last_name}"
  end


end
