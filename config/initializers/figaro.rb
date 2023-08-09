# frozen_string_literal: true

unless ENV["CI"]
  env = Rails.env
  keys = %w(SECRET_KEY_BASE)
  keys += %w(DB_DATABASE DB_PASSWORD DB_USERNAME)
  unless env.development? || env.test?
    keys += %w(MAILER_SMTP_ADDRESS MAILER_SMTP_DOMAIN MAILER_SMTP_PORT MAILER_SMTP_USER_NAME MAILER_SMTP_PASSWORD)
    keys += %w(GEOCODER_LOOKUP_API_KEY)
    keys += %w(OMNIAUTH_FACEBOOK_APP_ID OMNIAUTH_FACEBOOK_APP_SECRET OMNIAUTH_GOOGLE_CLIENT_ID OMNIAUTH_GOOGLE_CLIENT_SECRET)
  end
  Figaro.require_keys(keys)
end
