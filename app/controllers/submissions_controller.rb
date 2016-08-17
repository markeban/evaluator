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
    @respondent_id = params[:respondent_id]
  end

  def complete

  end




  def create
    submission_id = params[:submission][:respondent_id]
    submission_only = submission_params.except(:respondent_id)
    @submission = Submission.new(submission_only)
    if @submission.save
      Respondent.find(submission_id).update(responded: true) unless submission_id.blank?   
      flash[:success] = "Submission added successfully"
    end
    redirect_to '/submissions/complete'
  end

  private

  def submission_params
    params.require(:submission).permit(:evaluation_id, :respondent_id, answers_attributes: [:answer, :question_id])
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