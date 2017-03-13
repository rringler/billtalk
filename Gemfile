ruby '2.3.1'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',                    '~> 5.0.1'
gem 'pg'
gem 'puma',                     '~> 3.0'
gem 'sass-rails',               '~> 5.0'
gem 'uglifier',                 '>= 1.3.0'
gem 'jquery-rails'
gem 'webpacker',                github: 'rails/webpacker'
gem 'webpacker-react',          '~>0.1.0'
gem 'active_model_serializers', '~> 0.10.0'
gem 'knock'

group :development, :test do
  gem 'annotate'
  gem 'ffaker'
  gem 'listen',             '~> 3.1.5'
  gem 'rspec-rails',        '>= 3.5.2'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'pry-byebug'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '~> 1.5.3'
  gem 'timecop'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'mini_racer', platforms: :ruby
