require 'rubygems'
require 'bundler'
Bundler.require :default, :webapp, (ENV['RACK_ENV'] || "development").to_sym

Dir["./lib/*.rb"].each { |f| require f }

set :haml, format: :html5, attr_wrapper: %{"}
set :title, "Stream status"

# Streams to monitor
# [id, name, :service]
set :streams, streams = [
		{
			id: 131174,
			name: "Echo",
			service: :own3d
		},
		{
			id: "DanDinh",
			name: "Dan Dinh",
			service: :twitch
		},
		{
			id: "P10DotA",
			name: "P10",
			service: :twitch
		}
	]

settings.streams.each do |s|
	stream = Stream.new(s[:id], s[:service])
	s[:is_live] = stream.is_live?
	s[:viewers] = stream.viewers
	s[:uri]     = stream.uri
end

get '/' do
	@title = settings.title
	@streams = settings.streams

	haml :index
end
