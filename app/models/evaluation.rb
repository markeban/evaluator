class Evaluation < ActiveRecord::Base
  include HumanTime

  belongs_to :template
  belongs_to :teacher
  has_many :submissions
  has_many :answers, :through => :submissions
  has_many :respondents

  validates :subject, :message, presence: true, on: :update

  def template_position
    template = self.template
    teacher = self.teacher
    evaluation_ids = template.evaluations.where(template_id: template.id, teacher_id: teacher.id).map{|evaluation| evaluation.id}
    evaluation_ids.index(self.id) + 1
  end

  def scale_calculations
    @submissions = self.submissions
    @teacher = self.teacher

        @questions_array_scale = []
        @averages_for_questions_scale = []
        self.template.questions.where(:format_type => "scale1To10").each do |question| 
            @questions_array_scale << question.text
            answers_scale = self.answers.where(:question_id => question.id).map(&:answer).map(&:to_i)
            @averages_for_questions_scale << (answers_scale.sum / answers_scale.count.to_f).round(1)
        end
        @percentage_colors_scale =[]
        @averages_for_questions_scale.each do |average|
          case 
            when average > 9
              @percentage_colors_scale << "#009900"
            when average > 8
              @percentage_colors_scale << "#39aa00"
            when average > 7
              @percentage_colors_scale << "#a3c400"
            when average > 5
              @percentage_colors_scale << "#d4b100"
            when average > 3
              @percentage_colors_scale << "#e67300"            
            else
              @percentage_colors_scale << "#ff0000"
          end
        end
    return [@submissions, @teacher, @questions_array_scale, @averages_for_questions_scale, @percentage_colors_scale]  
  end

  def boolean_calculations
    boolean_submissions = self.submissions
    @questions_array_boolean = []
    @percentages_for_questions_boolean = []
      self.template.questions.where(:format_type => "boolean").each do |question|
        @questions_array_boolean << question.text
        answers_boolean = self.answers.where(:question_id => question.id).map(&:answer).map(&:to_i)
        @percentages_for_questions_boolean << (answers_boolean.sum / answers_boolean.count.to_f).round(2)
      end

      @percentage_colors_boolean =[]
      @percentages_for_questions_boolean.each do |percentage|
        case 
          when percentage > 0.9
            @percentage_colors_boolean << "#009900"
          when percentage > 0.8
            @percentage_colors_boolean << "#39aa00"
          when percentage > 0.7
            @percentage_colors_boolean << "#a3c400"
          when percentage > 0.5
            @percentage_colors_boolean << "#d4b100"
          when percentage > 0.3
            @percentage_colors_boolean << "#e67300"            
          else
            @percentage_colors_boolean << "#ff0000"
        end
      end
    return [@questions_array_boolean, @percentages_for_questions_boolean, @percentage_colors_boolean, boolean_submissions]  
  end

  def multiple_choice_calculations
    multiple_choice_submissions = self.submissions
    @questions_array_multiple_choice = []
    @percentages_for_questions_multiple_choice = []
    self.template.questions.where(:format_type => "multipleChoice").each do |question| 
      @questions_array_multiple_choice << question.text
      answers_multiple_choice = self.answers.where(:question_id => question.id).map(&:answer)
      each_question = []
      question.question_options.each do |option|
        each_question << {name: option.text, y: ((answers_multiple_choice.count(option.text).to_f / answers_multiple_choice.length)
          .round(2))}
      end
      @percentages_for_questions_multiple_choice << each_question
    end
    return [@questions_array_multiple_choice, @percentages_for_questions_multiple_choice, multiple_choice_submissions]
  end

  def text_calculations
    questions_text = []
    answers_text = []
    self.template.questions.where(:format_type => "text").each do |question| 
      questions_text << question.text
      answers_text << self.answers.where(:question_id => question.id).map(&:answer)
    end
    @questions_answers = []
    questions_text.each_with_index do |question, index|
      @questions_answers << {question: question, answers: answers_text[index], date: created_at}
    end
  return @questions_answers
  end

  def email_respondents_for_first_time
    respondents.where(emailed: false).each do |respondent|
      EvaluationMailer.email_respondent(respondent).deliver_now
      respondent.update_attribute(:emailed, true)
    end
    respondents
  end

end
