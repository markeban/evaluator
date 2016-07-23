class Template < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :evaluations
  has_many :submissions
  has_many :teachers, :through => :evaluations
  has_many :answers, :through => :questions

  def get_all_instructors_per_template_data
    all_instructors_per_template_data = []
    teachers.uniq.each do |teacher|
      all_instructors_per_template_data << teacher.get_data_per_instructor_per_template(self)
    end
    format_for_highcharts(all_instructors_per_template_data)
  end

  private

  def format_for_highcharts(all_instructors_per_template_data)
    all_instructors_per_template_data
    binding.pry
  end

end
