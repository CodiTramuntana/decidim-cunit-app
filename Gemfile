# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { git: 'https://github.com/decidim/decidim.git', branch: 'release/0.22-stable' }

gem "decidim", DECIDIM_VERSION
gem 'decidim-initiatives', DECIDIM_VERSION
gem 'decidim-consultations', DECIDIM_VERSION
gem 'decidim-conferences', DECIDIM_VERSION
# IMPORTANT replace the organization from file_authorization_handler to MarsBased, remove the branch key and remove this comment
gem 'decidim-file_authorization_handler', git: "https://github.com/CodiTramuntana/decidim-file_authorization_handler.git", branch: "fix/organization_error_on_manage_new_participant"
gem 'decidim-term_customizer', git: "https://github.com/CodiTramuntana/decidim-module-term_customizer"

gem "bootsnap", "~> 1.3"

gem "puma", "~> 4.3.3"
gem "uglifier", "~> 4.1"

gem "faker", "~> 1.9"

gem "figaro"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end

group :production do
  gem "passenger"
  gem 'delayed_job_active_record'
  gem "daemons"
end
