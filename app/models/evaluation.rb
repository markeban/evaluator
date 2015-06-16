class Evaluation < ActiveRecord::Base
  belongs_to :template
  belongs_to :teacher
  has_many :submissions
  has_many :answers, :through => :submissions


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
    return [@questions_array_boolean, @percentages_for_questions_boolean, @percentage_colors_boolean]  
  end

  def multiple_choice_calculations
    @questions_array_multiple_choice = []
      @percentages_for_questions_multiple_choice = []
      self.template.questions.where(:format_type => "multipleChoice").each do |question| 
        @questions_array_multiple_choice << question.text
        answers_multiple_choice = self.answers.where(:question_id => question.id).map(&:answer)
        question.question_options.each do |option|
          @percentages_for_questions_multiple_choice << [option.text, (answers_multiple_choice.count(option.text).to_f / answers_multiple_choice.length)
            .round(2)]
        end
      end
    return [@questions_array_multiple_choice, @percentages_for_questions_multiple_choice]
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
        @questions_answers << [question, answers_text[index]]
      end
    return @questions_answers
  end

  def instructor_only_scale_calculations
    averages_of_all_questions_array_scale = []
    @evaluation_start_dates = []

    questions_scale = self.first.submissions.first.questions.where(:format_type => "scale1To10").map(&:text)
    self.each do |evaluation|
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

  def instructor_only_boolean_calculations
    questions_boolean = self.last.submissions.first.questions.where(:format_type => "boolean").map(&:text)
    averages_of_all_questions_array_boolean = []
    self.each do |evaluation|
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
