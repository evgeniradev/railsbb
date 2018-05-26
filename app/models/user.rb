class User < ApplicationRecord
  has_many :topics
  has_many :posts

  mount_uploader :avatar, AvatarUploader

  enum status: { active: 0, disabled: 1 }
  enum role:   { standard: 0, admin: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: { case_sensitive: false }
  validates :username, length: { minimum: 3, maximum: 15 }
  validates :description, length: { minimum: 2, maximum: 40 }, allow_blank: true
  validates :terms_and_conditions, acceptance: true

  def active_for_authentication?
    super && active?
  end

  def self.newest
    active.last
  end
end
