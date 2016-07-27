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
    scale_1_to_10_questions = []
    all_instructors_per_template_data.each do |instructor|
      series_group = []
      instructor[:averages].each do |question, averages|
        data = instructor[:evaluation_start_dates].map.with_index { |date, index| [(date.to_f * 1000).to_i, averages[index]] }
        hash_for_highcharts = {
          name: instructor[:teacher],
          data: data
        }
        series_group << {question_text: question, series: hash_for_highcharts}
      end
      scale_1_to_10_questions << series_group
    end
    # binding.pry
    scale_1_to_10_questions
  end

end
