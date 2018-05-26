# frozen_string_literal: true

module SectionsHelper
  include SharedHelper
  include ExtraPostsHelper

  def title(section)
    action_name == 'show' ? 'Forum' : section.title
  end
end
