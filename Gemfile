source 'https://rubygems.org'

ruby '> 2.6.0'
gem 'pg'
gem 'standalone_migrations', '~> 5'
gem 'thor'
gem 'money'

group :development, :test do
  gem 'database_cleaner-active_record'
  gem 'faker'
  gem 'guard'
  gem 'guard-rspec'
  gem 'pry', '< 0.13'
  gem 'rspec'
end

group :test do
  gem 'factory_bot', require: false
  gem 'simplecov'
  gem 'timecop'
end
