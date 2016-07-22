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
    @specific_template = Template.find_by(:id => params[:id])
    @teacher = Teacher.find_by(:id => params[:teacher])
    @evaluations = @specific_template.evaluations.where(:teacher_id => @teacher.id)
    specific_instructor_only_scale_calculations = instructor_only_scale_calculations(@evaluations)
    @evaluation_start_dates = specific_instructor_only_scale_calculations[0]
    @averages = specific_instructor_only_scale_calculations[1]
    @averages_boolean = instructor_only_boolean_calculations(@evaluations)
  end


  def template
    @template = current_user.templates.find_by(:id => params[:template_id])
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

  def evaluation_params
    params.require(:evaluation).permit(:id, :template_id, :teacher_id)
  end
end



  