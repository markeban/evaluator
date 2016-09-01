class Api::V1::RespondentsController < ApplicationController
  before_action :authenticate_user!
  

  def index
    @respondents = Respondent.where(evaluation_id: params[:evaluation_id])
    render json: @respondents
  end

  def batch
    respondents = params[:respondents]
    @respondents = respondents.map {|respondent| create(respondent)}
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


  private

  def batch_params
    params.permit(respondents_attributes:[:email, :first_name, :last_name, :evaluation_id])
  end


end
