class Api::V1::EvaluationsController < ApplicationController

  def update
    evaluation = Evaluation.find_by(id: params[:id])
    evaluation.update(subject: params[:subject], message: params[:message])
    evaluation.email_respondents
    redirect_to "/api/v1/evaluations/email_respondents/#{evalution.id}"
  end

  def email_respondents
    evaluation = Evaluation.find_by(id: params[:id])
    respondents.each do |respondent|
      EvaluationMailer.email_respondent(respondent)
      respondent.update(emailed:true)
    end
    render json: evaluation.respondents
  end

end
