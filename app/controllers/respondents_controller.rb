class RespondentsController < ApplicationController

  def unsubscribe
    if respondent = Respondent.read_access_token(params[:signature])
      @signature = params[:signature]
    else
      flash[:warning] = "Invalid Link"
      redirect_to "/"
    end
  end

  def update
    respondent = Respondent.read_access_token(params[:signature])
    if params[:type] === "user"
      respondent.update(unsubscribed_to_user: true)
    elsif
      params[:type] === "all"
      respondent.update(unsubscribed_to_all: true)
    else
      flash[:warning] = "Invalid Link"
      redirect_to "/"
    end
  end
end
