source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.0'
gem 'jbuilder', '~> 2.5'

gem 'paperclip'
gem 'acts-as-taggable-on', git: 'https://github.com/mbleigh/acts-as-taggable-on.git'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'rack-cors'
gem 'httpclient'

group :development, :test do
  # gem 'byebug', platform: :mri
  gem 'spreadsheet'
  gem 'roo'
  gem 'faker'
  gem 'pry'
  gem 'byebug'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
