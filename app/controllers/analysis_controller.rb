class AnalysisController < ApplicationController
#Since there is no analysis.rb model, Model logic is in evaluation.rb
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
      specific_scale_calculations = @specific_evaluation.scale_calculations
      @submissions = specific_scale_calculations[0]
      @teacher = specific_scale_calculations[1]
      @questions_array_scale = specific_scale_calculations[2]
      @averages_for_questions_scale = specific_scale_calculations[3]
      @percentage_colors_scale = specific_scale_calculations[4]

      specific_boolean_calculations = @specific_evaluation.boolean_calculations
      @questions_array_boolean = specific_boolean_calculations[0]
      @percentages_for_questions_boolean = specific_boolean_calculations[1]
      @percentage_colors_boolean = specific_boolean_calculations[2]

      specific_multiple_choice_calculations = @specific_evaluation.multiple_choice_calculations
      @questions_array_multiple_choice = specific_multiple_choice_calculations[0]
      @percentages_for_questions_multiple_choice = specific_multiple_choice_calculations[1]

      @questions_answers = @specific_evaluation.text_calculations
  end


  def instructor_only_show_template
    @specific_template = Template.find_by(:id => params[:id])
    @teacher = Teacher.find_by(:id => params[:teacher])
    @evaluations = @specific_template.evaluations.where(:teacher_id => @teacher.id)

    specific_instructor_only_scale_calculations = @evaluations.instructor_only_scale_calculations
    @evaluation_start_dates = specific_instructor_only_scale_calculations[0]
    @averages = specific_instructor_only_scale_calculations[1]

    @averages_boolean = @evaluations.instructor_only_boolean_calculations
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