require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReceptenBoek
  class Application < Rails::Application
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.secret_token = '6f22fa632e18b338b4babfa5fca632f5454fc97317cb52f372fa0f0fdd7f4d5bd95a060ff412c7230627b5c17906c9762c09208624bc1ab97f8d5344d8d4f467'  
    config.filter_parameters << :password  
    config.middleware.use "PDFKit::Middleware"
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
  end
end
