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
  set :cache, IronCache::Client.new
  set :cache_name, 'stream_status'
  set :cache_ttl, 180

  # Static file cache
  set :static_cache_control, [:public, :max_age => 7*86400]

  # Haml settings
  set :haml, format: :html5, attr_wrapper: %{"}
  set :default_title, "Stream status"

  # Streams to monitor by default
  set :default_streams, [
    'http://www.twitch.tv/guardsmanbob',
    'http://www.twitch.tv/wingsofdeath',
    'http://www.twitch.tv/sp4zie',
    'http://www.twitch.tv/riotgames',
    'http://hashd.tv/echo',
    'http://twitch.tv/smitegame',
    'http://twitch.tv/ciderhelm'
  ]

  # Whitelisted sites
  set :domain_whitelist, [
    'http://forums.penny-arcade.com/',
  ]

  # Blacklisted sites
  set :domain_blacklist, []

end

Dir["./{lib,helpers}/**/*.rb"].each { |f| require f }
