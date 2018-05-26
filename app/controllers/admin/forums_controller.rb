# frozen_string_literal: true

module Admin
  class ForumsController < ForumsController
    before_action :authenticate_user!, :admin_permission

    layout 'admin'

    default_actions do
      admin_forums_path
    end
  end
end
