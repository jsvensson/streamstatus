require "#{File.dirname(__FILE__)}/setup.rb"
set :app_file, __FILE__  # Unbreak Bundler.

before do
  @cache = ObjectCache.new(settings.cache, settings.cache_name)
end

get '/' do
  @streams = []
  settings.default_streams.each { |url| @streams << update_stream(url, @cache) }
  @streams.sort!.reverse!

  haml :index
end

get '/stream/:service/:stream_id.png' do
  url = build_url(params[:service].to_sym, params[:stream_id])
  @stream = update_stream(url, @cache)

  response['Cache-Control'] = "no-cache, max-age=180"
  redirect status_image(@stream.is_live?)
end

get '/stream/:service/:stream_id' do
  url = build_url(params[:service].to_sym, params[:stream_id])
  @stream = update_stream(url, @cache)

  haml :stream
end
