class AnalysisController < ApplicationController

  def index
    @teacher_select = []   
    unique_teachers = current_user.teachers.uniq
    unique_teachers.each do |teacher|
      @teacher_select << [teacher.full_name, teacher.id]
    end
    # @template_select = []
    # unique_templates = current_user.templates.uniq
    #   unique_templates.each do |template|
    #   @template_select << [template.name, template.id]
    # end

  end

  def instructor_only
    @teacher = Teacher.find_by(:id => params[:teacher_id])
    @evaluations = @teacher.evaluations


  end
  
  def instructor_only_show
      @specific_evaluation = Evaluation.find_by(:id => params[:id])   
      @submissions = @specific_evaluation.submissions
      @teacher = @specific_evaluation.teacher

      @questions_array_scale = []
      @averages_for_questions_scale = []
      @specific_evaluation.template.questions.where(:format_type => "scale1To10").each do |question| 
          @questions_array_scale << question.text
          answers_scale = @specific_evaluation.answers.where(:question_id => question.id).map(&:answer).map(&:to_i)
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

      @questions_array_boolean = []
      @percentages_for_questions_boolean = []
      @specific_evaluation.template.questions.where(:format_type => "boolean").each do |question|
        @questions_array_boolean << question.text
        answers_boolean = @specific_evaluation.answers.where(:question_id => question.id).map(&:answer).map(&:to_i)
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

      @questions_array_multiple_choice = []
      @percentages_for_questions_multiple_choice = []
      @specific_evaluation.template.questions.where(:format_type => "multipleChoice").each do |question| 
        @questions_array_multiple_choice << question.text
        answers_multiple_choice = @specific_evaluation.answers.where(:question_id => question.id).map(&:answer)
        question.question_options.each do |option|
          @percentages_for_questions_multiple_choice << [option.text, (answers_multiple_choice.count(option.text).to_f / answers_multiple_choice.length)
            .round(2)]
        end
      end

      questions_text =[]
      answers_text =[]
      @specific_evaluation.template.questions.where(:format_type => "text").each do |question| 
        questions_text << question.text
        answers_text << @specific_evaluation.answers.where(:question_id => question.id).map(&:answer)
      end
      @questions_answers = []
      questions_text.each_with_index do |question, index|
        @questions_answers << [question, answers_text[index]]
      end

  end


  def instructor_only_show_template
    @specific_template = Template.find_by(:id => params[:id])
    @teacher = Teacher.find_by(:id => params[:teacher])
    @evaluations = @specific_template.evaluations.where(:teacher_id => @teacher.id)

    averages_of_all_questions_array_scale = []
    @evaluation_start_dates = []

    questions_scale = @evaluations.first.submissions.first.questions.where(:format_type => "scale1To10").map(&:text)
    @evaluations.each do |evaluation|
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


    questions_boolean = @evaluations.last.submissions.first.questions.where(:format_type => "boolean").map(&:text)
    averages_of_all_questions_array_boolean = []
    @evaluations.each do |evaluation|
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



  end


  def template_only
    @template = current_user.templates.find_by(:id => params[:template_id])

  end

  def evaluation_params
    params.require(:evaluation).permit(:id, :template_id, :teacher_id)
  end
end



    # submissions.each do |submission|
    #   ind_submissions << submission.id
    # end



     #redirect_to /instructor_only
    # @questions_array_scale_scale = [] 
    # questions.each do |question|
    #   @questions_array_scale_scale << question.text
    # end

        # @templates = @teacher.templates
    # @submissions.each_with_index do |submission, sub|
    #   # submission.answers.each_with_index do |answer, ans|
    #   #   puts @submissions_avg[ans]
    #   #   @submissions_avg[ans] += answer.answer.to_i
    #   # end
    #   # @submissions_avg[sub] == (@submissions_avg[sub] / @submissions.length )
    #   submission.
    # end


    # @questions_array_scale_scale = @specific_evaluation.template.questions.map(&:text)  