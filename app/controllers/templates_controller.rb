class TemplatesController < ApplicationController
  def new
    @template = Template.new
  end

  def create
    Template.create(params[:template])
  end



  def index
    @templates = Template.all
  end

  def show
    @template = Template.find_by(:id => params[:id])
  end
end
