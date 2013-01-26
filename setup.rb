require 'rubygems'
require 'bundler'
Bundler.require :default, :webapp, (ENV['RACK_ENV'] || "development").to_sym

# Set root for log file
set :root, Dir.pwd
set :logger_level, :debug

# Cache settings
set :cache, (ENV["MEMCACHE_SERVERS"] || Dalli::Client.new)
set :cache_ttl, 30

# Haml settings
set :haml, format: :html5, attr_wrapper: %{"}
set :title, "Stream status"

# Streams to monitor by default
set :streams, [
		"http://www.own3d.tv/Echo5ive/live/131174"
	]
set :streamlist, []


Dir["./{lib,helpers}/**/*.rb"].each { |f| require f }

