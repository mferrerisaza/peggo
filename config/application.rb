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
      generate.test_framework :rspec,
        view_specs: false,
        controller_specs: false,
        helper_specs: false,
        routing_specs: false,
        request_specs: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :es
    config.time_zone = 'Bogota'
    config.active_record.default_timezone = :local
  end
end
