class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  after_filter :set_csrf_cookie_for_ng
  helper_method :human_month_day_year_time

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def authenticate_admin_user!
    redirect_to root_path if (current_user == nil) || current_user.student
  end

  def human_month_day_year_time(unformatted_time)
    unformatted_time.strftime("%B %d, %Y")
  end




  protected

  # Override Rails CSRF token requests (w/Angular)
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end
end
