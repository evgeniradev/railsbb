# frozen_string_literal: true

class TopicsController < ApplicationController
  include DefaultActions

  before_action :authenticate_user!
  before_action :admin_permission, only: %i[edit destroy]

  default_actions(belongs_to: :forum, has_many: :posts) do |topic|
    case action_name
    when 'create'
      forum = topic.forum
      section = forum.section
      primary_post = Post.new(content: post_params[:content], kind: :primary)
      primary_post.user = current_user
      primary_post.forum = forum
      primary_post.section = section
      topic.section = section
      topic.user = current_user
      topic.posts << primary_post
      add_errors(primary_post)
    when 'update'
      primary_post = topic.primary_post
      primary_post.update(content: post_params[:content])
      add_errors(primary_post)
    when 'destroy'
      next topic.forum
    when 'show'
      current_views = @topic.views
      current_views += 1
      # 'update_column' is needed instead of 'update' in order
      # to avoid updating the 'updated_at' column
      @topic.update_columns views: current_views
    end

    topic if flash[:errors].blank?
  end

  def add_errors(primary_post)
    flash[:errors] += primary_post.errors.full_messages unless primary_post.valid?
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :forum_id)
  end

  def post_params
    params.permit(:content)
  end
end
