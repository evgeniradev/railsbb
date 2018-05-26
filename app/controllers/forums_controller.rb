# frozen_string_literal: true

class ForumsController < ApplicationController
  include DefaultActions

  before_action :authenticate_user!
  before_action :admin_permission, only: %i[new create edit destroy]

  default_actions(belongs_to: :section, has_many: :topics)

  private

  def forum_params
    params.require(:forum).permit(:title, :description, :section_id)
  end
end
