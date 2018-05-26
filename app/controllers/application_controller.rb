# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_time_zone
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout 'public'

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username terms_and_conditions])
    devise_parameter_sanitizer.permit(:account_update, keys: [:description])
  end

  def admin_permission
    redirect_to root_path unless current_user.admin?
  end

  def settings
    Rails.cache.fetch(:settings) || Rails.cache.fetch(:settings) do
      Setting.first
    end
  end

  helper_method :settings

  private

  def set_time_zone
    Time.zone = settings.time_zone
  rescue StandardError
    Rails.cache.delete :settings
  end
end
