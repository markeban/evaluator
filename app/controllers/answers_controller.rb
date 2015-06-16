class AnswersController < ApplicationController

  def show
    @evaluation = Evaluation.find_by(:url => params[:id])
    @submission = Submission.new(:evaluation_id => @evaluation.id)
    if @submission.save
      flash[:success] = "Question added successfully"
      #redirect_to template_questions_path(@template)
    end
    @answer = Answer.new()

    @questions = @evaluation.template.questions
    @answer = @questions.answer
    @template = @evaluation.template
    @teacher = @evaluation.teacher


  end


  
end
