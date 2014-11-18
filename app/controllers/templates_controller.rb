class TemplatesController < ApplicationController
  def new
    @template = Template.new
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      flash[:success] = "Template added successfully"
      redirect_to new_question_path+"?template_id="+@template.id.to_s
    else
      render 'new'
    end
  end

  def index
    @templates = Template.all
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
