class Teacher < ActiveRecord::Base
  has_many :templates, :through => :evaluations
  has_many :evaluations
  has_many :submissions, :through => :evaluations
  belongs_to :user

  def full_name
    "#{first_name} #{last_name}"
  end

  def get_data_per_instructor_per_template(template)
    specific_template = evaluations.where(template_id: template.id)
    specific_instructor_only_scale_calculations = instructor_only_scale_calculations(specific_template)
    instructor_data_hash = {
      evaluation_start_dates: specific_instructor_only_scale_calculations[0],
      averages: specific_instructor_only_scale_calculations[1],
      averages_boolean: instructor_only_boolean_calculations(specific_template)
    }
    return instructor_data_hash
  end

  private

  def instructor_only_scale_calculations(evaluations)
    averages_of_all_questions_array_scale = []
    @evaluation_start_dates = []

    questions_scale = evaluations.first.submissions.first.questions.where(:format_type => "scale1To10").map(&:text)
    evaluations.each do |evaluation|
      @evaluation_start_dates << evaluation.created_at.strftime("%A, %b, %d %Y %l:%M %p")
      averages_for_questions_scale = []
      evaluation.template.questions.where(:format_type => "scale1To10").each do |question| 
          answers_scale = evaluation.answers.where(:question_id => question.id).map(&:answer).map(&:to_i)
          averages_for_questions_scale << (answers_scale.sum / answers_scale.count.to_f).round(1)
      end
      averages_of_all_questions_array_scale << averages_for_questions_scale  
    end
    averages_of_all_questions_array_scale_trans = averages_of_all_questions_array_scale.transpose
    @averages = {}
    questions_scale.each_with_index do |question, index|
      @averages[question] = averages_of_all_questions_array_scale_trans[index]
    end
    return [@evaluation_start_dates, @averages]
  end

  def instructor_only_boolean_calculations(evaluations)
    questions_boolean = evaluations.last.submissions.first.questions.where(:format_type => "boolean").map(&:text)
    averages_of_all_questions_array_boolean = []
    evaluations.each do |evaluation|
      questions_array_boolean = []
      averages_for_questions_boolean = []
      evaluation.template.questions.where(:format_type => "boolean").each do |question|
        questions_array_boolean << question.text
        answers_boolean = evaluation.answers.where(:question_id => question.id).map(&:answer).map(&:to_i)
        averages_for_questions_boolean << (answers_boolean.sum / answers_boolean.count.to_f).round(2)
      end
      averages_of_all_questions_array_boolean << averages_for_questions_boolean
     

    end
    averages_of_all_questions_array_boolean_trans = averages_of_all_questions_array_boolean.transpose
    @averages_boolean = {}
    questions_boolean.each_with_index do |question, index|
      @averages_boolean[question] = averages_of_all_questions_array_boolean_trans[index]
    end
    return @averages_boolean
  end

end
