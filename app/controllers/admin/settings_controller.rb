# frozen_string_literal: true

module Admin
  class SettingsController < ApplicationController
    include DefaultActions

    before_action :authenticate_user!, :admin_permission

    layout 'admin'

    default_actions do
      clear_cache

      admin_settings_path
    end

    def index
      @settings = Setting.first
    end

    private

    def clear_cache
      return unless action_name == 'create' || action_name == 'update'

      Rails.cache.delete(:settings)
    end

    def setting_params
      params.require(:setting).permit(
        :title,
        :description,
        :time_zone,
        :logo,
        :cookies_warning,
        :terms_and_conditions
      )
    end
  end
end
