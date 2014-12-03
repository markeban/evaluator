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
    @questions_array = []
    @averages_for_questions = []
    @recent_evaluation.template.questions.each do |question|
      @questions_array << question.text
      answers = @recent_evaluation.answers.where(:question_id => question.id).map(&:answer).map(&:to_i)
      @averages_for_questions << (answers.sum / answers.count.to_f).round(1)
    end
    # @submissions.each_with_index do |submission, sub|
    #   # submission.answers.each_with_index do |answer, ans|
    #   #   puts @submissions_avg[ans]
    #   #   @submissions_avg[ans] += answer.answer.to_i
    #   # end
    #   # @submissions_avg[sub] == (@submissions_avg[sub] / @submissions.length )
    #   submission.
    # end
    puts "Stuff Below"
    p @averages_for_questions

    # @questions_array = @recent_evaluation.template.questions.map(&:text)  

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