# frozen_string_literal: true

module FormActionHelper
  # If blank, the request will be send to the Update action
  def action
    action_name == 'new' || action_name == 'create' ? { action: :create } : { action: :update }
  end
end
