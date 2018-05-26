class Forum < ApplicationRecord
  include SharedValidations
  include CacheManagement

  after_commit -> { delete_sections_cache :sections }

  belongs_to :section
  has_many :topics, dependent: :destroy
  has_many :posts

  validates :description, presence: true
  validates :description, length: { maximum: 40 }
  validates :title, uniqueness: { scope: :section_id, message: 'can only exist once per section' }
end
