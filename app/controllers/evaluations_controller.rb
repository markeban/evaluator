class EvaluationsController < ApplicationController

  before_action :authenticate_user!

  def new
    @teacher_select = []   
    unique_teachers = current_user.teachers.uniq
    unique_teachers.each do |teacher|
      @teacher_select << [teacher.full_name, teacher.id]
    end
    
    @template_select = []
    unique_templates = current_user.templates.uniq
    unique_templates.each do |template|
      @template_select << [template.name, template.id]
    end
    @evaluation = Evaluation.new
  end

  def create
    @evaluation = Evaluation.new(evaluation_params)
    

    begin
      @evaluation.url = SecureRandom.hex(4).upcase
    end while Evaluation.find_by(:url => @evaluation.url) # or (url: eval_link)


    if @evaluation.save
      flash[:success] = "Evaluation created successfully"
      redirect_to evaluation_path(@evaluation)
    else
      render 'new'
    end
  end

  def show
    @evaluation = Evaluation.find_by(:id => params[:id])
    @questions = @evaluation.template.questions

    # respondents = params[:respondent_details].split("\r\n").reject(&:empty?)
    # successful_creates = []
    # errors = []
    # respondents.each do |respondent_detail_string|
    #   respondent_details = respondent_detail_string.split(",")
    #   first_name = respondent_details[0]
    #   last_name = respondent_details[1]
    #   email = respondent_details[2]
    #   new_respondent = User.new(cohort_id: params[:cohort_id], email: email, first_name: first_name, last_name: last_name, password: "changeme", role_id: 3)
    #   if new_respondent.save
    #     PortalMailer.welcome_respondent(new_student).deliver_now
    #     successful_creates << "<span style='color:green'>Account created successfully for #{new_student.full_name} and welcome email sent to #{new_student.email} </span>"
    #   else
    #     errors << "<span style='color:red'>For #{new_student.full_name}, #{new_student.errors.full_messages.join(", ")}</span>"
    #   end
    end
    message = ""
    message << successful_creates.join("<br/>") if successful_creates.any?
    message << "<br/><br/>" if successful_creates.any? && errors.any?
    message << errors.join("<br/>") if errors.any?
    flash[:warning] = message
    redirect_to cohorts_path


  end


  private

  def evaluation_params
    params.require(:evaluation).permit(:teacher_id, :template_id, :url)
  end


end
