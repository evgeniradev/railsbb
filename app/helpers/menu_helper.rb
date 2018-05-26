# frozen_string_literal: true

module MenuHelper
  module UserAccount
    def user_account
      links = [sign_up, profile, account_settings, admin_site, login_logout].compact
      content_tag(:ul, class: 'user-options') do
        links.collect do |link|
          content_tag :li, link
        end.join.html_safe
      end
    end

    def admin_site
      link_to 'Admin', admin_root_path if current_user.try :admin?
    end

    def profile
      link_to 'Profile', profile_user_path(current_user) if user_signed_in?
    end

    def account_settings
      link_to 'My Account', edit_user_registration_path if user_signed_in?
    end

    def sign_up
      link_to 'Sign up', new_user_registration_path unless user_signed_in?
    end

    def login_logout
      if user_signed_in?
        return link_to(
          "Log out(#{current_user.username})",
          destroy_user_session_path,
          method: :delete
        )
      end

      link_to('Log in', new_user_session_path)
    end
  end

  module AdminAccount
    def admin_account
      links = [public_site, login_logout].compact
      content_tag(:ul, class: 'user-options') do
        links.collect do |link|
          content_tag :li, link
        end.join.html_safe
      end
    end

    def public_site
      link_to 'Public', root_path
    end

    def login_logout
      if user_signed_in?
        return link_to(
          "Log out(#{current_user.username})",
          destroy_user_session_path,
          method: :delete
        )
      end

      link_to('Log in', new_user_session_path)
    end
  end

  module CurrentPath
    def current_path
      separator = content_tag(:span, '/', class: 'separator')
      content_tag(:ul, class: 'current-path') do
        links.collect do |link|
          content_tag :li, link
        end.join(separator).html_safe
      end
    end

    def links
      home =
        if controller.class.parent.name == 'Admin'
          link_to('Admin', admin_root_path)
        else
          link_to('Home', root_path)
        end

      @links = [home]
      current_page =
        @heading || case controller_name.to_sym
                    when :sessions
                      'Log in'
                    when :registrations
                      registrations_link
                    when :sections
                      @section.try(:title)
                    when :forums
                      forum_link
                    when :topics
                      topic_link
                    when :posts
                      post_link
                    else
                      controller_name.capitalize
                    end

      @links << current_page
      @links.compact
    end

    def registrations_link
      @heading
    end

    def post_link
      return  @heading if params[:search]

      topic = @post.topic || Topic.find(params[:post][:topic_id])
      forum = topic.forum
      section = forum.section
      @links << link_to(section.title, section)
      @links << link_to(forum.title, forum)
      @links << link_to(topic.title, topic)
      @heading
    end

    def forum_link
      section = @forum.section || Section.find(params[:forum][:section_id])
      @links << link_to(section.title, section)
      @heading || @forum.title
    end

    def topic_link
      forum = @topic.forum || Forum.find(params[:topic][:forum_id])
      section = @topic.forum.try(:section) || forum.section
      @links << link_to(section.title, section)
      @links << link_to(forum.title, forum)
      @heading || @topic.title
    end
  end

  include UserAccount
  include AdminAccount
  include CurrentPath

  def public_menu
    current_path + user_account
  end

  def admin_menu
    current_path + admin_account
  end
end
