require 'rubygems'
require 'bundler'
Bundler.require :default, :webapp, (ENV['RACK_ENV'] || "development").to_sym

configure do

  # Heroku seems to not pass an actual $PORT, set it in app
  set :port, ENV['PORT'] || 5000

  # Logging?
  enable :logging

  # Set root for log file
  set :root, Dir.pwd
  set :logger_level, :debug

  # Cache settings
  set :cache, (ENV["MEMCACHE_SERVERS"] || Dalli::Client.new)
  set :cache_ttl, 180

  # Haml settings
  set :haml, format: :html5, attr_wrapper: %{"}
  set :default_title, "Stream status"

  # Streams to monitor by default
  set :default_streams, [
    "http://www.twitch.tv/EchoPA",
    "http://www.twitch.tv/dandinh",
    "http://www.twitch.tv/mojang",
    "http://www.twitch.tv/vman7",
    "http://www.twitch.tv/wingsofdeath"
  ]
end

Dir["./{helpers,lib}/**/*.rb"].each { |f| require f }
