class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name(
    ENV.fetch("MAIL_FROM_ADDRESS", "hello@example.com"),
    ENV.fetch("MAIL_FROM_NAME", "Example")
  )
  layout "mailer"

  def default_url_options
    { host: ENV.fetch("APP_URL", "http://localhost") }
  end
end
