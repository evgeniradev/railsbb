# frozen_string_literal: true

module PostsHelper
  include ExtraPostsHelper

  def post_content
    params[:content] || @post.try(:content) || quote
  end

  def quote
    return unless params[:quote]

    post = Post.find(params[:quote][:post_id])
    user = post.user
    username = user.disabled? ? DISABLED_USER_USERNAME : user.username
    # rubocop:disable Metrics/LineLength
    raw "<blockquote class='quote'>#{username}, #{post.updated_at.strftime(DATE_FORMAT)}<br>#{post.content}</blockquote><br>"
    # rubocop:enable Metrics/LineLength
  end

  def user_link(user)
    return DISABLED_USER_USERNAME if !user || user.disabled?

    link_to user.username, profile_user_path(user), class: 'username'
  end

  def user_info(user)
    content_tag(:ul, class: 'user-info') do
      row_names = %w[posts joined description]

      row_names.collect do |name|
        content_tag :li do
          val =
            if !user || user.disabled?
              'n/a'
            else
              case name
              when 'posts'
                user.posts.size
              when 'joined'
                user.created_at.strftime(DATE_FORMAT)
              when 'description'
                user.description
              end
            end

          next unless val.present?

          [
            content_tag(:span, "#{name.capitalize}: "),
            content_tag(:span, val)
          ].join.html_safe
        end
      end.join.html_safe
    end
  end

  def id_element(post, topic)
    "topic_#{topic.id}_post_#{post.id}"
  end

  def zone(post, topic)
    date = content_tag(:p) do
      action = post.created_at == post.updated_at ? 'Posted' : 'Edited'
      "#{action} on #{post.updated_at.strftime(DATETIME_FORMAT)} "
    end

    topic = content_tag(:p) do
      link = link_to(
        topic.title,
        topic_path(topic, anchor: post_anchor(post), page: page_number(post)),
        target: '_blank'
      )
      content = raw format('in %<link>s', link: link)
      content unless controller_name == 'topics'
    end

    zones = [date, topic]

    content_tag(:ul) do
      zones.collect do |link|
        content_tag :li, link
      end.join.html_safe
    end
  end

  def actions(post, topic)
    container = []
    unless controller_name == 'posts'
      add_admin_actions(container, post, topic)
      container << button_to(
        'Quote',
        new_post_path,
        method: :get,
        class: 'btn-post',
        params: {
          'post[topic_id]': topic.id,
          'quote[post_id]': post.id
        }
      )
    else
      container << link_to(
        'Open Topic',
        topic_path(topic, anchor: post_anchor(post), page: page_number(post)),
        class: 'btn btn-post open-topic',
        target: '_blank'
      )
    end
    container.join.html_safe
  end

  def add_admin_actions(container, post, topic)
    return unless current_user.admin?

    if post.primary?
      delete_warning = 'Are you sure you want to delete the whole topic?'
      container << button_to(
        'Edit',
        edit_topic_path(topic),
        method: :get,
        class: 'btn-post'
      )
      container << button_to(
        'Delete',
        topic_path(topic),
        method: :delete,
        class: 'btn-post',
        data: { confirm: delete_warning }
      )
    else
      container << button_to(
        'Edit',
        edit_post_path(post),
        method: :get,
        class: 'btn-post'
      )

      container << button_to(
        'Delete',
        post_path(post),
        method: :delete,
        class: 'btn-post'
      )
    end
  end
end
