class AnalysisController < ApplicationController

  def index
    @teacher_select = []
      Teacher.all.each do |teacher|
      @teacher_select << [teacher.full_name, teacher.id]
    end
    @template_select = []
      Template.all.each do |template|
      @template_select << [template.name, template.id]
    end

  end

  def instructor_only
    @teacher = Teacher.find_by(:id => params[:teacher_id])
    @recent_evaluation = @teacher.evaluations.last
    @submissions = @recent_evaluation.submissions
    @submissions_avg = []
    average = 0
    @submissions.each do |submission|
      submission.answers.each do |answer|
        average += answer.answer.to_i
      end
      @submissions_avg << (average / submission.answers.length )
    end


    @questions_array = @recent_evaluation.template.questions.map(&:text)  

  end
  

  def template_only
    @template = current_user.templates.find_by(:id => params[:template_id])



  end
end

    # submissions.each do |submission|
    #   ind_submissions << submission.id
    # end



     #redirect_to /instructor_only
    # @questions_array = [] 
    # questions.each do |question|
    #   @questions_array << question.text
    # end