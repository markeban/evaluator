class Api::V1::EvaluationsController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_current_user_evaluation!

  def show
    render json: @evaluation
  end
  
  def update
    @evaluation.update(subject: params[:email_contents][:subject], message: params[:email_contents][:message])
    @evaluation.email_respondents_for_first_time
    render json: @evaluation.respondents
  end


end
