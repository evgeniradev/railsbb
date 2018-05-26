# frozen_string_literal: true

module TopicsHelper
  # PostsHelper is included as the post partial is rendered in the TopicsController
  include PostsHelper
  include SharedHelper

  def content_invalid?
    return unless flash[:errors]

    flash[:errors].any? { |error| error =~ /Content/ }
  end

  def topic_content
    params[:content] || @topic.primary_post.try(:content)
  end
end
