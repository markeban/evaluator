class Api::V1::RespondentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @respondents = Respondent.where(evaluation_id: params[:evaluation_id])
    render json: @respondents
  end

  def batch
    respondents = batch_params[:respondents]
    @respondents = respondents.map {|respondent| create(respondent)} 
    #using jbuilder to create complex json view
  end

  def destroy
    @respondent = Respondent.find(params[:id]).destroy
    render json: @respondent
  end

  private

  def create(respondent)
    respondent = Respondent.new(first_name: respondent[:first_name], last_name: respondent[:last_name], email: respondent[:email], evaluation_id: respondent[:evaluation_id], emailed:false)
    respondent.save
    return respondent
  end

  def batch_params
    params.permit(respondents: [:first_name, :last_name, :email, :unsaved, :emailed, :evaluation_id])
  end

end
