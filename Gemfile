ruby '2.3.1'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',                    '~> 5.1'
gem 'pg'
gem 'puma',                     '~> 3.11'
gem 'sass-rails',               '~> 5.0'
gem 'uglifier',                 '~> 1.3'
gem 'jquery-rails'
gem 'webpacker',                '~> 3.0'
gem 'webpacker-react'
gem 'active_model_serializers', '~> 0.10'
gem 'knock'

group :development, :test do
  gem 'annotate'
  gem 'ffaker'
  gem 'listen',             '~> 3.1'
  gem 'rspec-rails',        '~> 3.7'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '~> 1.6'
  gem 'timecop'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'mini_racer', platforms: :ruby
