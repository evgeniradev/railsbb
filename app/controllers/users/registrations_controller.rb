# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    prepend_before_action :authenticate_scope!, only: %i[show edit update destroy disable]

    def show
      @user = User.find params[:id]
      redirect_to(root_path) if @user.disabled? && !current_user.admin?
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

    def disable
      if resource.update status: :disabled
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        flash[:notification] = 'You account has been disabled.'
        redirect_to new_user_session_path
      else
        render 'devise/registrations/edit'
      end
    end
  end
end
