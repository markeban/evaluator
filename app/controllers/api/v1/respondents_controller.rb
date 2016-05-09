class Api::V1::RespondentsController < ApplicationController

  def index
    @respondents = Respondent.where(evaluation_id: params[:evaluation_id])
    render json: @respondents
  end

  def batch
    respondents = params[:respondents]
    @respondents = respondents.map {|respondent| create(respondent)}
    render json: @respondents
  end

  def create(respondent)
    respondent = Respondent.new(first_name: respondent[:first_name], last_name: respondent[:last_name], email: respondent[:email], evaluation_id: respondent[:evaluation_id], emailed:false)
    respondent.save
    return respondent
  end

  def destroy
    Respondent.find(params[:id]).destroy
    render json: "OK"
  end


end
