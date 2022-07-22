source "https://rubygems.org/"

# Read ruby version from .ruby-version file
ruby File.read('.ruby-version', mode: 'rb').chomp

gem 'sinatra', '~>2.2.1'
gem 'tilt', '~>2.0'
gem 'rack', '~>2.2.4'
gem 'rack-protection', '~>2.2.1'
gem 'math24', '~>2.0.0'
gem 'require_all', '~>1.4.0'
gem 'thin', '~>1.8.0'

group :development, :test do
  gem 'rspec', '3.11.0'
  gem 'rspec-core', '3.11.0'
  # Needed by CircleCI for test results
  gem 'rspec_junit_formatter'
  gem 'rack-test'
  gem 'byebug'
end

group :production do
  gem 'newrelic_rpm', '~>3.17.1'
end
