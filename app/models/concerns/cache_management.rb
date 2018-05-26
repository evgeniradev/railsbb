module CacheManagement
  extend ActiveSupport::Concern

  def delete_sections_cache(name)
    Rails.cache.delete(name)
  end
end
