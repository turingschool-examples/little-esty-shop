require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LittleEtsyShop
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Unsplash.configure do |config|
    #   config.application_access_key = "_VRZaA4Cz8JuLunDFcNISWMY36sxkTdZA6cEeqMGq50"
    #   config.application_secret = "MvRhSvVZn8xEuyHXFsoO_mlMYeu5TQejFKTpImm9uas"
    #   config.application_redirect_uri = "https://unsplash.com/oauth/applications/438268"
    #   config.utm_source = "alices_terrific_client_app"
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
