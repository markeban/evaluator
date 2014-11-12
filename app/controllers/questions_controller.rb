class QuestionsController < ApplicationController

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Question added successfully"
      redirect_to template_path(@question.template.id)
    else
      render 'new'
    end
  end


  private

  def question_params
    params.require(:question).permit(:text, :required, :format_type, :template_id)
  end

end
