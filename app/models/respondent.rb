class Respondent < ActiveRecord::Base
  belongs_to :evaluation

  def full_name
    "#{first_name} #{last_name}"
  end
end
