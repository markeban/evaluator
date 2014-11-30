class AnalysisController < ApplicationController

  def index
    @teacher = Teacher.find_by(:id => params[:teacher_id])
    @template = current_user.templates.find_by(:id => params[:template_id])

    @teacher_select = []
      Teacher.all.each do |teacher|
      @teacher_select << [teacher.full_name, teacher.id]
    end
    @template_select = []
      Template.all.each do |template|
      @template_select << [template.name, template.id]
    end

    # questions = current_user.templates.find_by(:id => 15).questions
    questions = @template.questions
    @questions_array = [] 
    questions.each do |question|
      @questions_array << question.text
    end


  end
end
