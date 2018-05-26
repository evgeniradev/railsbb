# frozen_string_literal: true

module StatisticsHelper
  def newest_user_link
    newest_user = User.newest
    return 'n/a' unless newest_user

    link_to newest_user.username, profile_user_path(newest_user)
  end

  %w[users topics posts].each do |name|
    method_name = format('%<name>s_count', name: name)

    define_method(method_name) do
      model = name.singularize.capitalize.constantize
      model.count
    end
  end
end
