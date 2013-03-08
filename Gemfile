source 'https://rubygems.org'

ruby '1.9.3'

gem 'httparty'
gem 'resque', '~> 1.22.0'
gem 'dalli', '~> 2.6.0'
gem 'iron_worker_ng'

group :webapp do
	gem 'sinatra'
	gem 'sinatra-logger'
	gem 'thin'
	gem 'haml'
end

group :development do
  gem 'rerun'
	gem 'growl'
	gem 'guard'
	gem 'guard-rspec'
	gem 'rb-fsevent', '~> 0.9.1'
end

group :test do
	gem 'rake'
	gem 'rspec', '~> 2.12.0'
end
