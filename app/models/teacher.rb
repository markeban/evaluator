class Teacher < ApplicationRecord
  include HumanTime
  
  has_many :templates, :through => :evaluations
  has_many :evaluations
  has_many :submissions, :through => :evaluations
  belongs_to :user

  validates :name, presence: true

  def get_data_per_instructor_per_template(template)
    evaluations_specific_template = evaluations.where(template_id: template.id)
    specific_instructor_only_scale_calculations = instructor_only_scale_calculations(evaluations_specific_template)
    instructor_data_hash = {
      teacher: self.name,
      URLs: get_urls(template),
      evaluation_start_dates: specific_instructor_only_scale_calculations[0],
      averages: specific_instructor_only_scale_calculations[1],
      averages_boolean: instructor_only_boolean_calculations(evaluations_specific_template),
      multiple_choice: specific_instructor_multiple_choice_calculations(evaluations_specific_template),
      text: specific_instructor_text_answers(evaluations_specific_template)
    }
    return instructor_data_hash
  end


  def has_multiple_submissions_over_muliple_evals(template_id)
    submissions_booleans = evaluations.where(template_id: template_id).map(&:submissions).map(&:any?)
    true_booleans = submissions_booleans.select{|boolean| boolean == true}.count
    true_booleans > 1 ? true : false
  end

  private

  def get_urls(template)
    evaluations.where(template_id: template.id).map {|evaluation| evaluation.id }
  end

  def instructor_only_scale_calculations(evaluations)
    averages_of_all_questions_array_scale = []
    @evaluation_start_dates = []
    evals_with_submissions = evaluations.select{|evaluation| evaluation.submissions.any?}
    questions_scale = evals_with_submissions.first.submissions.first.questions.where(:format_type => "scale1To10").map(&:text)
    evals_with_submissions.each do |evaluation|
      @evaluation_start_dates << evaluation.created_at
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
    questions_boolean = evaluations.last.template.questions.where(:format_type => "boolean").map(&:text)
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

  def specific_instructor_multiple_choice_calculations(evaluations)
    calculations_per_evaluation = evaluations.map{ |evaluation| evaluation.multiple_choice_calculations }
    questions = calculations_per_evaluation.map {|evaluation| {question: evaluation[0], scores: evaluation[1]} }
    if questions.first[:question].any?
      table_format = get_table_format(questions)
      remapped_questions = []
      question_index = 0
      while question_index < questions.first[:question].length 
        questions.each do |evaluation|
          points_across_questions = []
          evaluation[:scores][question_index].each_with_index do |choice, score_set_index|
            scores_grouped = []
            questions_iterated = 0
            questions.length.times do
              scores_grouped << questions[questions_iterated][:scores][question_index][score_set_index][:y]
              questions_iterated += 1
            end
            points_across_questions << {choice: questions.first[:scores][question_index][score_set_index][:name], scores: scores_grouped}
          end
          remapped_questions << {question: evaluation[:question][question_index] , data: points_across_questions}
        end
        question_index += 1
      end
      return {teacher: evaluations.first.teacher.name, chart: remapped_questions, table: table_format}
    else
      return nil
    end
  end

  def get_table_format(questions)
    all_sets = []
    questions.each_with_index do |question, index|
      sets = []
      question[:scores].each_with_index do |score_all, index|
        sets << score_all.map{|individual_score| {name: individual_score[:name], score: individual_score[:y]}}
      end
      all_sets << sets
    end
    sets_transposed = all_sets.transpose
    returned_questions = []
    sets_transposed.each_with_index do |set, index|
      hash = {}
      hash[:question] = questions.first[:question][index]
      hash[:scores] = set
      returned_questions << hash
    end
    returned_questions
  end

  def specific_instructor_text_answers(evaluations)
    transposed_evals = evaluations.map{ |evaluation| evaluation.text_calculations }.transpose
    properly_nested = []
    transposed_evals.each do |transposed_eval|
      better_hash = {question: transposed_eval.first[:question]}
      answers = []
      better_hash[:different_dates] = transposed_eval.map{|eval| {date: eval[:date], texts: eval[:answers]} }
      properly_nested << better_hash
    end
    return properly_nested
  end

end
