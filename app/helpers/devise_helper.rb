# frozen_string_literal: true

module DeviseHelper
  # This overwrites the default devise method
  def devise_error_messages!
    flash[:errors] = resource.errors.full_messages
  end
end
