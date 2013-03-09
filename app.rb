require "#{File.dirname(__FILE__)}/setup.rb"
set :app_file, __FILE__  # Unbreak Bundler.

get '/' do
  @cache = ObjectCache.new(settings.cache)
  @streams = []
  settings.default_streams.each { |url| @streams << update_stream(url, @cache) }
  @streams.sort!.reverse!

  haml :index
end

get '/stream/:service/:stream_id' do
  @cache = ObjectCache.new(settings.cache)
  url = build_url(params[:service].to_sym, params[:stream_id])
  @stream = update_stream(url, @cache)

	haml :stream
end
