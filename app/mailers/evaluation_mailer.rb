class EvaluationMailer < ApplicationMailer


  def email_respondent(respondent)
    @respondent = respondent
    mail(from: "markebanr@gmail.com", to: @respondent.email, subject: @respondent.evaluation.subject, cc: "markebanr@gmail.com")
  end



end
