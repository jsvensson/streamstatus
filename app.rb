require "#{File.dirname(__FILE__)}/setup.rb"
set :app_file, __FILE__  # Unbreak Bundler.

get '/' do
  @cache = ObjectCache.new(settings.cache)
  @streams = []
  settings.default_streams.each { |str| @streams << update_stream(str, @cache) }

  haml :index
end

get '/stream/:service/:stream_id' do
	service = params[:service].to_sym
	stream_id = params[:stream_id]

	haml :stream
end
