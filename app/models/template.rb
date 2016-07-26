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
    return format_for_highcharts(all_instructors_per_template_data)
  end

  private

  def format_for_highcharts(all_instructors_per_template_data)
    all_instructors_per_template_data
    scale_1_to_10_questions = [] # get all questions!
    series = []
    all_instructors_per_template_data.each do |instructor|
      data = instructor[:evaluation_start_dates].map.with_index { |date, index| [(date.to_f * 1000).to_i, instructor[:averages].values[0][index]] }
      hash_for_highcharts = {
        name: instructor[:averages].keys.first,
        data: data
      }
      series << hash_for_highcharts
    end
    series.to_json
    binding.pry
  end

end
