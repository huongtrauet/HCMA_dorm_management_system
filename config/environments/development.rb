Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # config.action_mailer.default_url_options = {host: "localhost:3000"}
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.delivery_method = :mailgun
  # config.action_mailer.mailgun_settings = {
  #   api_key: 'c8b21d3b0cae1bc6a51f30626a045c1a-07e45e2a-4c33090b',
  #   domain: 'https://api.mailgun.net/v3/sandboxfdd15f167c0548b193583a13310e1030.mailgun.org',
  # }
  # config.action_mailer.smtp_settings = {
  #   user_name: 'postmaster@sandboxfdd15f167c0548b193583a13310e1030.mailgun.org',
  #   password: 'ee834b409c59024957ca5a3bce19fca6-07e45e2a-80e630d2',
  #   address: 'smtp.mailgun.org',
  #   domain: 'smtp.mailgun.org',
  #   port: '587',
  #   authentication: :cram_md5,
  #   enable_starttls_auto: true
  # }
  config.action_mailer.delivery_method = :smtp
  # host = 'localhost:3000' #replace with your own url
  config.action_mailer.default_url_options = { :host => 'localhost:3000', protocol: 'http' }
  
  # SMTP settings for gmail
  config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :user_name            => "huongtranguyen2111@gmail.com",
    :password             => "ykjzrvwukofzcbiz",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }

end
