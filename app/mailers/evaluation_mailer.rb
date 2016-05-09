class EvaluationMailer < ApplicationMailer


  def email_respondent(respondent)
    @respondent = respondent
    mail(from: "no-reply@anyonecanlearntocode.com", to: @respondent.email, subject: @respondent.evaluation.subject, bcc: "markeban@yahoo.com", cc: "markeban@yahoo.com")
  end



end
