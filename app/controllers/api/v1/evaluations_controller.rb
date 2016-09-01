class Api::V1::EvaluationsController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_current_user_evaluation!

  def show
    render json: @evaluation
  end
  
  def email_respondents
    subject = params[:email_contents][:subject]
    message = params[:email_contents][:message]
    if @evaluation.update(subject: subject, message: message)
      @evaluation.email_respondents_for_first_time
      render json: @evaluation.respondents
    else
      respond_to do |format|
        format.json { render template: 'api/v1/evaluations/email_respondents.json.jbuilder', status: 422 }
      end
    end
  end


end
