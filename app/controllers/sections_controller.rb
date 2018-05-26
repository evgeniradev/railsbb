# frozen_string_literal: true

class SectionsController < ApplicationController
  include DefaultActions

  before_action :admin_permission, only: %i[new create edit destroy]

  default_actions

  def index
    @sections = Rails.cache.fetch(:sections) || Rails.cache.fetch(:sections) do
      Section.all
    end
  end
end
