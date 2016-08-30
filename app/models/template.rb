class Template < ActiveRecord::Base
  include HumanTime

  belongs_to :user
  has_many :questions, :dependent => :destroy
  has_many :evaluations, :dependent => :destroy
  has_many :submissions, -> { order(:updated_at) }, through: :evaluations
  has_many :teachers, -> { distinct }, :through => :evaluations
  has_many :answers, :through => :questions

  validates :name, presence: true

  def get_all_instructors_per_template_data
    all_instructors_per_template_data = []
    teachers.uniq.each do |teacher|
      all_instructors_per_template_data << teacher.get_data_per_instructor_per_template(self)
    end
    scale_1_to_10s = get_series_highcharts(all_instructors_per_template_data, :averages)
    booleans = get_series_highcharts(all_instructors_per_template_data, :averages_boolean)
    multiple_choice = get_highcharts_multiple_choice(all_instructors_per_template_data)
    return {scale_1_to_10s: scale_1_to_10s, booleans: booleans, multiple_choice: multiple_choice, texts: get_texts(all_instructors_per_template_data)}
  end

  def last_submission
    submissions.any? ? submissions.last.updated_at.strftime("%B %d, %Y") : "None"
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

  def get_highcharts_multiple_choice(instructors)
    instructors.map{|instructor| instructor[:multiple_choice]}
  end

  def get_texts(instructors)
    instructors.map{|instructor| {teacher:instructor[:teacher], texts: instructor[:text]} }
  end

end




