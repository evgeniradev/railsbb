# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def terms_and_conditions
    @terms_and_conditions = settings.terms_and_conditions
  end
end
