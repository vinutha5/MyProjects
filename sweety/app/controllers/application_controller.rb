class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  protect_from_forgery
  skip_before_action :verify_authenticity_token, :only => [:login,:autheticate]
  
  # Overload handle_unverified_request to ensure that
  # exception is raised each time a request does not
  # pass validation.
  def handle_unverified_request
    raise(ActionController::InvalidAuthenticityToken)
  end
end
