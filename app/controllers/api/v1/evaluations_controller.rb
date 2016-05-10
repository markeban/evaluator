class Api::V1::EvaluationsController < ApplicationController

  def update
    evaluation = Evaluation.find_by(id: params[:id])
    evaluation.update(subject: params[:email_contents][:subject], message: params[:email_contents][:message])
    evaluation.email_respondents_for_first_time
    render json: evaluation.respondents
  end

end
