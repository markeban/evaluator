class Teacher < ActiveRecord::Base
  has_many :templates, :through => :evaluations
  has_many :evaluations
  has_many :submissions, :through => :evaluations
  belongs_to :user

  def full_name
    "#{first_name} #{last_name}"
  end


end
