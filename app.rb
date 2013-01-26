require "#{File.dirname(__FILE__)}/setup.rb"
set :app_file, __FILE__  # Unbreak Bundler.

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
