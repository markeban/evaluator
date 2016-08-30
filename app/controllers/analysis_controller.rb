class AnalysisController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_current_user_teacher!, only: [:instructor_only, :instructor_only_show_template]
  before_action :restrict_current_user_template!, only: [:instructor_only_show_template, :template]

  def index
    @templates = current_user.templates
  end

  def instructor_only
    @evaluations = @teacher.evaluations
  end
  
  def instructor_only_show
    @evaluation = Evaluation.find_by(:id => params[:id])
    if current_user.id == @evaluation.teacher.user.id
      specific_scale_calculations = @evaluation.scale_calculations
      @submissions = specific_scale_calculations[0]
      @teacher = specific_scale_calculations[1]
      @questions_array_scale = specific_scale_calculations[2]
      @averages_for_questions_scale = specific_scale_calculations[3]
      @percentage_colors_scale = specific_scale_calculations[4]

      specific_boolean_calculations = @evaluation.boolean_calculations
      @questions_array_boolean = specific_boolean_calculations[0]
      @percentages_for_questions_boolean = specific_boolean_calculations[1]
      @percentage_colors_boolean = specific_boolean_calculations[2]
      @boolean_submissions = specific_boolean_calculations[3]

      specific_multiple_choice_calculations = @evaluation.multiple_choice_calculations
      @questions_array_multiple_choice = specific_multiple_choice_calculations[0]
      @percentages_for_questions_multiple_choice = specific_multiple_choice_calculations[1]
      @multiple_choice_submissions = specific_multiple_choice_calculations[2]

      @questions_answers = @evaluation.text_calculations
    else
      flash[:danger] = "You don't have access to that particular page"
      redirect_to "/"
    end
  end


  def instructor_only_show_template
    data = @teacher.get_data_per_instructor_per_template(@template)
    data[:evaluation_start_dates].map!{|date| date = date.strftime("%b %d, %Y")}
    @instructor_data_hash = data
  end


  def template
    @all_instructors_per_template_data = @template.get_all_instructors_per_template_data
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:id, :template_id, :teacher_id)
  end
end



  