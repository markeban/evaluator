class AnalysisController < ApplicationController

  def index
    @teacher_select = []
      Teacher.all.each do |teacher|
      @teacher_select << [teacher.full_name, teacher.id]
    end
    @template_select = []
      Template.all.each do |template|
      @template_select << [template.name, template.id]
    end

  end

  def instructor_only
    @teacher = Teacher.find_by(:id => params[:teacher_id])
    @evaluations = @teacher.evaluations


  end
  
  def instructor_only_show
      @specific_evaluation = Evaluation.find_by(:id => params[:id])   
      @submissions = @specific_evaluation.submissions

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


  end


  def instructor_only_show_template
    @specific_template = Template.find_by(:id => params[:id])
    @evaluations = @specific_template.evaluations

    # @questions_array_scale << question.text
    # @questions_array_scale = []
    @averages_of_all_questions_array_scale = []
    @evaluations.each do |evaluation|
      averages_for_questions_scale = []
      evaluation.template.questions.where(:format_type => "scale1To10").each do |question| 
          answers_scale = evaluation.answers.where(:question_id => question.id).map(&:answer).map(&:to_i)
          averages_for_questions_scale << (answers_scale.sum / answers_scale.count.to_f).round(1)
      end
      @averages_of_all_questions_array_scale << [evaluation.created_at, averages_for_questions_scale]
    end



    # @percentage_colors_scale =[]
    # @averages_for_questions_scale.each do |average|
    #   case 
    #     when average > 9
    #       @percentage_colors_scale << "#009900"
    #     when average > 8
    #       @percentage_colors_scale << "#39aa00"
    #     when average > 7
    #       @percentage_colors_scale << "#a3c400"
    #     when average > 5
    #       @percentage_colors_scale << "#d4b100"
    #     when average > 3
    #       @percentage_colors_scale << "#e67300"            
    #     else
    #       @percentage_colors_scale << "#ff0000"
    #   end
    # end




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