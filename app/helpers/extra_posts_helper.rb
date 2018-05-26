# frozen_string_literal: true

# These 2 methods are needed throughout the app hence the separate module
module ExtraPostsHelper
  include ConstantsHelper

  def post_anchor(post)
    topic = post.topic
    return unless topic

    "topic_#{topic.id}_post_#{post.id}"
  end

  # This method finds the page a post is located on
  def page_number(post)
    topic = post.topic
    return unless topic

    all_posts = topic.posts.order(:created_at).to_a
    total_pages = (all_posts.length / POSTS_PER_PAGE.to_f).ceil
    return 1 if total_pages == 1

    post_location = all_posts.index(post) + 1
    1.upto(total_pages).detect do |page|
      last_post_location = page * POSTS_PER_PAGE
      first_post_location = last_post_location - POSTS_PER_PAGE
      post_location.between?(first_post_location, last_post_location)
    end
  end
end
