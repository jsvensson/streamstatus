source 'https://rubygems.org'

ruby '1.9.3'
group :default do
  gem 'httparty', :group => :worker
end

group :webapp do
	gem 'sinatra'
	gem 'sinatra-logger'
	gem 'thin'
	gem 'haml'
  gem 'iron_worker_ng'
  gem 'iron_cache', :group => :worker
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
	gem 'rspec', '~> 2.13.0'
end
