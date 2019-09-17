require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Peggo
  class Application < Rails::Application
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.active_job.queue_adapter = :sidekiq
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework  :test_unit, fixture: true
    end
    config.load_defaults 6.0
    config.i18n.default_locale = :es
    config.time_zone = 'Bogota'
    config.active_record.default_timezone = :local
  end
end
