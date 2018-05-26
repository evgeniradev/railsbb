# frozen_string_literal: true

module Admin
  class SectionsController < SectionsController
    before_action :authenticate_user!, :admin_permission

    layout 'admin'

    default_actions do
      admin_sections_path
    end

    private

    def section_params
      params.require(:section).permit(:id, :title)
    end
  end
end
