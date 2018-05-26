# Module is namespaced due to Devise
module Users
  module RegistrationsHelper
    include PostsHelper
    include ExtraPostsHelper

    # Method of the same name exists in the SharedHelper
    def latest_user_post_link
      post = @user.posts.last
      topic = post.try(:topic)
      return 'n/a' unless post && topic

      link_to post.title, topic_path(topic, anchor: post_anchor(post), page: page_number(post))
    end
  end
end
