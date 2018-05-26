class Topic < ApplicationRecord
  include SharedValidations
  include CacheManagement

  after_commit -> { delete_sections_cache :sections }

  has_many :posts, dependent: :destroy
  belongs_to :section
  belongs_to :forum
  belongs_to :user

  validates :title, uniqueness: { scope: :forum_id, message: 'already exists in this forum' }

  def primary_post
    posts.primary.first
  end
end
