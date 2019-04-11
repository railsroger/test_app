source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'annotate'
gem 'babosa'
gem 'coffee-rails', '~> 4.2'
gem 'datashift'
gem 'delayed_paperclip'
gem 'execjs'
gem 'jbuilder', '~> 2.5'
gem 'letter_opener'
gem 'niceql'
gem 'paperclip-av-transcoder'
gem 'pg', '~> 0.18'
gem 'pismo'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rails-i18n', '~> 5.1'
gem 'redactor2_rails', '~> 0.1.4'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'slim-rails'
gem 'spree', '~> 3.4.4'
gem 'spree_auth_devise', '~> 3.3'
gem 'spree_gateway', '~> 3.3'
gem 'spree_sitemap', github: 'spree-contrib/spree_sitemap'
gem 'therubyracer'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 3.5.3'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'capistrano', '~> 3.8'
  gem 'capistrano-bundler', '~> 1.2'
  gem 'capistrano-rails', '~> 1.3'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'
  gem 'capistrano3-puma', github: 'seuros/capistrano-puma'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'web-console', '>= 3.3.0'
end
