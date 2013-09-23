class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def current_user?(user)
    user == current_user
  end

  def after_sign_up_path_for(resource)
    edit_user_path(current_user)
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit :first_name, :last_name, :email, :password
      end
    end
end
