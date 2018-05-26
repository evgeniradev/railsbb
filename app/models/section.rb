class Section < ApplicationRecord
  include SharedValidations
  include CacheManagement

  after_commit -> { delete_sections_cache :sections }

  has_many :forums, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :title, uniqueness: true
end
