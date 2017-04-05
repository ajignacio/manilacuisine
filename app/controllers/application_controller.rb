class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  protect_from_forgery with: :exception

  #before_action :authenticate_user!


  protected

    def configure_permitted_parameters
      #devise_parameter_sanitizer.for(:sign_up) do |u|
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name, :email, :password, :password_confirmation])
      #end
    end

end
