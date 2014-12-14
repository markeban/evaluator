class Api::V1::QuestionOptionsController < ApplicationController

  def new
    @question = Question.find_by(:id => params[:question_id])
    @template = @question.template
  end

  def create
    @question_option = QuestionOption.new(question_options_params)
    if @question_option.save

    else
      render json: { errors: @question.optionErrors.full_messages }, status: 422
    end
  end

  def show
    @template = Template.find_by(:id => params[:template_id])
    @questions = @template.questions
  end

  def batch_destroy
    params[:questions].each do |question|
      question = Question.find_by(:id => question[:id])
      question.destroy
    end
  end

  private



  def question_options_params
    params.require(:question_option).permit(:text, :question_id)
  end




end
