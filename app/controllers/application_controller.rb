class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: devise_keys)
    devise_parameter_sanitizer.permit(:account_update, keys: [:paypal_email])
  end

  def devise_keys
    [:email, :first_name, :last_name, :contact_number].freeze
  end
end
