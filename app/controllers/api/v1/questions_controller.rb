class Api::V1::QuestionsController < ApplicationController

def new
    @template = Template.find_by(:id => params[:template_id])
    @question = Question.new
  end


  def create
    @question = Question.new(question_params)
    @template = @question.template
    if @question.save
      flash[:success] = "Question added successfully"
      redirect_to template_questions_path(@template)
    else
      render 'new'
    end
  end

  def index
    @template = Template.find_by(:id => params[:template_id])
    @questions = @template.questions.all
  end

  def edit
    @template = Template.find_by(:id => params[:template_id])
    @question = @template.questions.find_by(:id => params[:id])
  end

  def update
    @template = Template.find_by(:id => params[:template_id])
    @question = @template.questions.find_by(:id => params[:id])
    @question.update(question_params)
    flash[:success] = "Template successfully updated"
    redirect_to template_questions_path(@template)
  end

  def destroy
    @template = Template.find_by(:id => params[:template_id])
    @question = @template.questions.find_by(:id => params[:id])
    @question.destroy
    flash[:danger] = "Template deleted"
    redirect_to template_questions_path(@template)
  end


  private

  def question_params
    params.require(:question).permit(:text, :required, :format_type, :template_id)
  end

end

