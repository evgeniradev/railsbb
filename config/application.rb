require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Railsbb
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # This alters the default rails config to use sass, and not scss
    config.sass.preferred_syntax = :sass

    # config.web_console.whitelisted_ips = '172.19.0.0/16'
    config.action_controller.include_all_helpers = false

    config.generators.test_framework :rspec
  end
end
