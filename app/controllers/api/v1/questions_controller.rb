class Api::V1::QuestionsController < ApplicationController

def new
    @template = Template.find_by(:id => params[:template_id])
    @question = Question.new
  end


  def create
    @question = Question.new(question_params)
    if @question.save
    else
      render json: { errors: @question.questionErrors.full_messages }, status: 422
    end
  end

  def index
    template_id = params[:template_id]
    @questions = Question.where(:template_id => template_id)
  end

  
  def destroy
    template = Template.find_by(:id => params[:id])
    template.questions.destroy_all
  end


  private

  def question_params
    params.require(:question).permit(:text, :required, :format_type, :template_id)
  end

end

