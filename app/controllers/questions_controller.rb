class QuestionsController < ApplicationController

  def new
    @template = Template.find_by(:id => params[:template_id])
    @question = Question.new
  end


  def create
    @question = Question.new(question_params)
    @template = @question.template
    if @question.save
      flash[:success] = "Question added successfully"
      redirect_to questions_path+"?template_id="+@template.id.to_s
    else
      render 'new'
    end
  end

  def index
    @template = Template.find_by(:id => params[:template_id])
    @questions = @template.questions.all
  end


  private

  def question_params
    params.require(:question).permit(:text, :required, :format_type, :template_id)
  end

end
