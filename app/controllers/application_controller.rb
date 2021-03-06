class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  after_action :set_csrf_cookie_for_ng
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :human_month_day_year_time, :human_boolean

  
  def after_sign_in_path_for(resource)
    "/analysis"
  end


  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def authenticate_admin_user!
    redirect_to root_path if (current_user == nil) || current_user.student
  end

  def human_month_day_year_time(unformatted_time)
    unformatted_time.strftime("%B %d, %Y")
  end

  def human_boolean(zero_or_one)
    zero_or_one == 1 ? 'Yes' : 'No'
  end
    
  def restrict_current_user_teacher!
    @teacher = Teacher.find_by(:id => params[:teacher_id])
    if current_user.id == @teacher.user.id
      return @teacher
    else
      flash[:danger] = "You don't have access to that particular page."
      redirect_to "/"
    end
  end

  def restrict_current_user_template!
    @template = Template.find_by(:id => params[:template_id]) || Template.find_by(:id => params[:id]) || Template.find_by(id: params[:questions].first[:template_id])
    if current_user.id == @template.user.id
      return @template
    else
      flash[:danger] = "You don't have access to that particular page."
      redirect_to "/"
    end
  end

  def restrict_current_user_evaluation!
    @evaluation = Evaluation.find_by(:id => params[:id])
    if current_user.id == @evaluation.teacher.user.id
      return @evaluation
    else
      flash[:danger] = "You don't have access to that particular page."
      redirect_to "/"
    end
  end

  def restrict_current_user_question!
    @question = Question.find_by(:id => params[:question_id])
    if current_user.id == @question.template.user.id
      return @question
    else
      flash[:danger] = "You don't have access to that particular page."
      redirect_to "/"
    end
  end

  def restrict_current_user_question_option!(option)
    @question_option = QuestionOption.find_by(:id => option[:id])
    if current_user.id == @question_option.question.template.user.id
      return @question_option
    else
      flash[:danger] = "You don't have access to that particular page."
      redirect_to "/"
    end
  end

  protected

  # Override Rails CSRF token requests (w/Angular)
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :password])
   end
end
