class Setting < ApplicationRecord
  include CacheManagement
  after_commit -> { delete_sections_cache :settings }
  mount_uploader :logo, LogoUploader
end
