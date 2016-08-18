class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_current_user_template!, only: [:show]

  def new
    @template = Template.new
  end


  def create
    @template = current_user.templates.new(template_params)
    if @template.save
      flash[:success] = "Template added successfully"
      redirect_to new_template_question_path(@template)
    else
      render 'new'
    end
  end

  def index
    @templates = current_user.templates.all
  end

  def show
    @template = Template.find_by(:id => params[:id])
    @question = Question.new
  end


  private

  def template_params
    params.require(:template).permit(:name)
  end

end
