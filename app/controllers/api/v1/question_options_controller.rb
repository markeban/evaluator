class Api::V1::QuestionOptionsController < ApplicationController

  def create
    @question_option = QuestionOption.new(question_options_params)
    if @question_option.save

    else
      render json: { errors: @question.optionErrors.full_messages }, status: 422
    end
  end

  private

  def question_options_params
    params.require(:question_option).permit(:text, :question_id)
  end




end
