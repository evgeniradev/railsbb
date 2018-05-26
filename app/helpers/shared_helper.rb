# frozen_string_literal: true

# Methods shared between the Sections, Forums and Topics controller
module SharedHelper
  include ConstantsHelper

  def latest_post(record)
    post = record.posts.last
    topic = post.try(:topic)
    return 'n/a' unless topic

    temp = []
    temp << content_tag(:p, latest_post_link(post), class: 'post-title')
    temp << content_tag(:p, class: 'post-date') do
      inner_temp = []
      inner_temp << post_date(post)
      inner_temp << content_tag(
        :span,
        record_author_link(post),
        class: 'post-author'
      )
      inner_temp.join.html_safe
    end
    temp.join.html_safe
  end

  # Method of the same name exists in the RegistrationsHelper
  def latest_post_link(post)
    return 'n/a' unless post

    link_to(
      post.title,
      topic_path(post.topic, anchor: post_anchor(post), page: page_number(post))
    )
  end

  def post_date(post)
    return unless post

    post.updated_at.strftime(DATETIME_FORMAT)
  end

  def record_author_link(topic_or_post)
    return unless topic_or_post

    user = topic_or_post.user
    return unless user

    link = link_to(user.username, profile_user_path(user))
    link = user.disabled? ? DISABLED_USER_USERNAME : link

    [content_tag(:span, ' by '), link].join.html_safe
  end

  def link_to_self(record)
    method_name = format('%<name>s_path', name: record.class.name.downcase)
    link_to record.title, public_send(method_name, record)
  end

  def add_button(record)
    model = record.class.name.downcase
    belongs_to =
      case model
      when 'section' then 'forum'
      when 'forum' then 'topic'
      when 'topic' then 'post'
      end

    # forums can only be added by admins
    return if !current_user.admin? && controller_name == 'sections'

    params_name = format(
      '%<belongs_to>s[%<model>s_id]',
      belongs_to: belongs_to, model: model
    )
    params = { params_name => record.id }
    method_name = format('new_%<belongs_to>s_path', belongs_to: belongs_to)
    btn_name = format('Add %<belongs_to>s', belongs_to: belongs_to)

    button_to(
      btn_name,
      public_send(method_name),
      method: :get,
      params: params,
      class: 'btn'
    )
  end
end
