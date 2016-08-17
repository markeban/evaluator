class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_current_user_template!
  
  def new
    # @question = @template.questions || Question.new
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
    @questions = @template.questions.all
  end

  def edit
    @question = @template.questions.find_by(:id => params[:id])
  end

  def update
    @question = @template.questions.find_by(:id => params[:id])
    @question.update(question_params)
    flash[:success] = "Product successfully updated"
    redirect_to template_questions_path(@template)
  end

  def destroy
    @question = @template.questions.find_by(:id => params[:id])
    @question.destroy
    flash[:danger] = "Product deleted"
    redirect_to template_questions_path(@template)
  end


  private

  def question_params
    params.require(:question).permit(:text, :required, :format_type, :template_id)
  end

end
