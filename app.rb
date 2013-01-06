require 'rubygems'
require 'bundler'
Bundler.require :default, :webapp, (ENV['RACK_ENV'] || "development").to_sym

Dir["./lib/*.rb"].each { |f| require f }

# Cache settings
set :cache, (ENV["MEMCACHE_SERVERS"] || Dalli::Client.new)
set :cache_ttl, 180

# Haml settings
set :haml, format: :html5, attr_wrapper: %{"}
set :title, "Stream status"

# Streams to monitor
# [id, name, :service]

set :streams, [
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

def update_streams
	settings.streams.map! do |stream|
		stream_id = "#{stream[:service]}-#{stream[:id]}"
		Stream.new(stream[:id], stream[:service])
	end
end

get "/" do
	update_streams

	@title = settings.title
	@streams = settings.streams

	haml :index
end

get '/stream/:service/:stream_id' do

	service = params[:service].to_sym
	stream_id = params[:stream_id]

	s = Stream.new(stream_id, service)

	@streams = []
	@streams << s

	haml :index
end
