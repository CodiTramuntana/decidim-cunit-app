# frozen_string_literal: true

unless ENV["CI"]
  env= Rails.env
  keys = %w(SECRET_KEY_BASE)

  unless env.development? || env.test?
    keys += %w(DATABASE_DB DATABASE_PASSWORD DATABASE_USERNAME)
    keys += %w(SMTP_ADDRESS SMTP_DOMAIN SMTP_PORT SMTP_USERNAME SMTP_PASSWORD)
    keys += %w(GEOCODER_LOOKUP_API_KEY)
    keys += %w(OMNIAUTH_FACEBOOK_APP_ID OMNIAUTH_FACEBOOK_APP_SECRET OMNIAUTH_GOOGLE_CLIENT_ID OMNIAUTH_GOOGLE_CLIENT_SECRET)
  end
  Figaro.require_keys(keys)
end
