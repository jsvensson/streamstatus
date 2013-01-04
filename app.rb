require 'rubygems'
require 'bundler'
require 'sinatra'

Dir["./lib/*.rb"].each { |f| require f }

get '/' do
	"Hello, world"
end
