# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { git: 'https://github.com/CodiTramuntana/decidim.git', branch: 'release/0.24-stable' }

gem "decidim", DECIDIM_VERSION
gem 'decidim-initiatives', DECIDIM_VERSION
gem 'decidim-consultations', DECIDIM_VERSION
gem 'decidim-conferences', DECIDIM_VERSION
gem 'decidim-templates', DECIDIM_VERSION
gem 'decidim-file_authorization_handler', git: "https://github.com/MarsBased/decidim-file_authorization_handler.git"
gem 'decidim-term_customizer', git: "https://github.com/mainio/decidim-module-term_customizer.git"

gem "bootsnap", "~> 1.3"

gem "puma", "~> 5"
gem "uglifier", "~> 4.1"

gem "faker", "~> 1.9"

gem "figaro"

gem "deface"

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
  gem 'delayed_job_active_record'
  gem "daemons"
end
