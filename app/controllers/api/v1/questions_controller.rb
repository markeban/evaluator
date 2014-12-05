class Api::V1::QuestionsController < ApplicationController

def new
    @template = Template.find_by(:id => params[:template_id])
    @question = Question.new
  end


  def create
    @question = Question.new(question_params)
    if @question.save
      # render json: @question
      # redirect_to template_questions_path(@template)
    else
      puts "ASDFASFDFSDF"
    end
  end

  def index
    @questions = Question.all
  end

  def edit
    @template = Template.find_by(:id => params[:template_id])
    @question = @template.questions.find_by(:id => params[:id])
  end

  def update
    @template = Template.find_by(:id => params[:template_id])
    @question = @template.questions.find_by(:id => params[:id])
    @question.update(question_params)
    flash[:success] = "Template successfully updated"
    redirect_to template_questions_path(@template)
  end

  def destroy
    @template = Template.find_by(:id => params[:template_id])
    @question = @template.questions.find_by(:id => params[:id])
    @question.destroy
    flash[:danger] = "Template deleted"
    redirect_to template_questions_path(@template)
  end


  private

  def question_params
    params.require(:question).permit(:text, :required, :format_type, :template_id)
  end

end

