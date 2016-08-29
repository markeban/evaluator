class EvaluationMailer < ApplicationMailer


  def email_respondent(respondent)
    @respondent = respondent
    mail(from: "no-reply@surveyblend.com", to: @respondent.email, subject: @respondent.evaluation.subject, cc: "no-reply@surveyblend.com")
  end



end
