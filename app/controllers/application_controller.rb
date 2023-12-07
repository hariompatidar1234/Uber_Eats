class ApplicationController < ActionController::Base
 # before_action :authenticate_admin_user!
 before_action :authenticate_user!

 before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:type])
  end

  # def after_sign_out_path_for(resource_or_scope)
  #    new_user_session_path
  #  end

     # Handle CanCanCan access denied
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message }, status: :forbidden
  end
end
