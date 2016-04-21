class Api::V1::RespondentsController < ApplicationController

  def index
    @respondents = Respondent.all
    render json: @respondents
  end

  def batch
    # @respondents
  end

  def create
  end


end
