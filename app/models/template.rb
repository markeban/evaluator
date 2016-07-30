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
    scale_1_to_10s = get_series_highcharts(all_instructors_per_template_data, :averages)
    booleans = get_series_highcharts(all_instructors_per_template_data, :averages_boolean)
    return {scale_1_to_10s: scale_1_to_10s, booleans: booleans}
  end

  private

  def get_series_highcharts(all_instructors_per_template_data, type)
    series = []
    all_instructors_per_template_data.each do |instructor|
      # urls_in_order = []
      # urls_in_order << instructor[:URL]
      specific_instructor_series = []
      instructor[type].each do |question, averages|
        data = instructor[:evaluation_start_dates].map.with_index { |date, index| [(date.to_f * 1000).to_i, averages[index]] }
        hash_for_highcharts = {
          name: instructor[:teacher],
          data: data,
          URLs: instructor[:URLs],
          lineWidth: 5,
          question_text: question
        }
        specific_instructor_series << hash_for_highcharts
      end
      series << specific_instructor_series
    end
    series.transpose
  end




end




