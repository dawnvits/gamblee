class Users::RegistrationsController < Devise::RegistrationsController
  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
