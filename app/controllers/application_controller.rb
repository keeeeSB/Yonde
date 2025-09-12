class ApplicationController < ActionController::Base
  before_action :configure_parmitted_parameters, if: :devise_controller?
  allow_browser versions: :modern

  def configure_parmitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name profile_image])
  end
end
