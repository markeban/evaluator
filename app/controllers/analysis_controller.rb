class AnalysisController < ApplicationController
#Since there is no analysis.rb model, Model logic is in evaluation.rb
  def index
    @teacher_select = []   
    unique_teachers = current_user.teachers.uniq
    unique_teachers.each do |teacher|
      @teacher_select << [teacher.full_name, teacher.id]
    end
    @template_select = []
    unique_templates = current_user.templates.uniq
      unique_templates.each do |template|
      @template_select << [template.name, template.id]
    end
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
    @teacher = Teacher.find_by(:id => params[:teacher])
    @template = Template.find_by(:id => params[:id])
    @instructor_data_hash = @teacher.get_data_per_instructor_per_template(@template)
  end


  def template
    @template = current_user.templates.find_by(:id => params[:template_id])
    @all_instructors_per_template_data = @template.get_all_instructors_per_template_data      
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:id, :template_id, :teacher_id)
  end
end



  