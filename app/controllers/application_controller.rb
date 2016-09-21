class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    current_user.admin ? games_path : super
  end

  def redirect_if_admin
    redirect_to games_path if current_user.admin
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: devise_keys)
    devise_parameter_sanitizer.permit(:account_update, keys: [:paypal_email])
  end

  def devise_keys
    [:email, :first_name, :last_name, :contact_number].freeze
  end
end
