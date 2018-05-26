# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    include DefaultActions

    before_action :authenticate_user!, :admin_permission

    layout 'admin'

    default_actions do
      admin_users_path
    end

    def index
      @users = User.all
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :status, :role)
    end
  end
end
