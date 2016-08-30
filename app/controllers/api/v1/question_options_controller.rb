class Api::V1::QuestionOptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_current_user_template!, only:[:show]
  before_action :restrict_current_user_question!, except: [:batch_destroy]
  # before_action :restrict_current_user_question_option!, only: [:batch_destroy]

  def new
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
    @questions = @template.questions
  end

  def batch_destroy
    params[:options].each do |option|
      @question_option = restrict_current_user_question_option!(option)
      @question_option.destroy
    end
    render json: "OK"
  end

  private

  def question_options_params
    params.require(:question_option).permit(:text, :question_id)
  end




end
