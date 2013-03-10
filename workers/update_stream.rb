require 'rubygems'
require 'bundler'
Bundler.require :default, :worker

require 'iron_cache'

Dir["./{lib/**/*.rb"].each { |f| require f }
