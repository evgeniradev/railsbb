# TODO: Not implemented yet
class BannedIp < ApplicationRecord
  require 'ipaddr'

  validates :ip_range, presence: true
  validate :matches_ip_format
  validates :ip_range, uniqueness: true

  def matches_ip_format
    # rubocop:disable Style/RescueModifier, Layout/EmptyLineAfterGuardClause
    return true if (IPAddr.new(ip_range) rescue false)
    # rubocop:enable Style/RescueModifier, Layout/EmptyLineAfterGuardClause

    errors.add(:ip_range, 'is not a valid IP range')
  end
end
