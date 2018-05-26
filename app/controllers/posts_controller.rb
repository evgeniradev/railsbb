# frozen_string_literal: true

class PostsController < ApplicationController
  include DefaultActions

  before_action :authenticate_user!
  before_action :admin_permission, only: %i[edit destroy]

  default_actions(belongs_to: :topic) do |post|
    topic = post.topic
    if action_name == 'create'
      post.user = current_user
      post.forum = topic.forum
      post.section = topic.section
      # This will move the topic to the top of the list in the view
      post.topic.update updated_at: Time.now
    end
    topic
  end

  def index
    if params[:search]
      @search_val = params[:search]
      @posts = Post.search @search_val
      render :search
    else
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:id, :content, :topic_id, :quote_post_id)
  end
end
