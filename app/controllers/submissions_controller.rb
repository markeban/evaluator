class SubmissionsController < ApplicationController

  def new
    @evaluation = Evaluation.find_by(:url => params[:id])
    @submission = Submission.new
    


    @questions = @evaluation.template.questions
    @questions.each do |question|
      @submission.answers.new(:question_id => question.id)
    end
    # @answer = @questions.answer
    @template = @evaluation.template
    @teacher = @evaluation.teacher


  end

  def create
    @submission = Submission.new(submission_params)
    if @submission.save
      flash[:success] = "Submission added successfully"
      #redirect_to template_questions_path(@template)
    end
    redirect_to '/templates'
  end

  private

  def submission_params
    params.require(:submission).permit(:evaluation_id, answers_attributes: [:answer, :question_id])
  end



end




# @question = Question.new(question_params)
#     @template = @question.template
#     if @question.save
#       flash[:success] = "Question added successfully"
#       redirect_to template_questions_path(@template)
#     else
#       render 'new'
#     end