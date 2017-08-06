source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.0'
gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'active_model_serializers', '~> 0.10.6'
gem 'bcrypt', '~> 3.1.7'
gem 'cancancan', '~> 2.0'
gem 'jwt', '~> 1.5.6'
gem 'kaminari', '~> 1.0.1'
gem 'redis', '~> 3.3', '>= 3.3.3'
gem 'redis-objects', '~> 1.3'
gem 'rails_param'
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
  gem 'rspec-rails', '~> 3.6'
  gem 'rspec_api_documentation', '~> 5.0'
  gem 'apitome', '~> 0.1.0'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'fakeredis', :require => 'fakeredis/rspec'
  gem 'simplecov', require: false
end

group :development do
  gem 'spring'
  gem 'mina', '~> 1.0.0', require: false
  gem 'mina-multistage', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
