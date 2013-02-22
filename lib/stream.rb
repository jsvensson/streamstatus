require 'rubygems'
require 'bundler'
Bundler.require :default, (ENV['RACK_ENV'] || "development").to_sym

class Stream

  attr_reader :name, :viewers, :stream_uri, :json_uri, :cache_id

  def initialize(stream_uri, options = {:update => true, :file => false})
    data = Stream::Service.normalize(stream_uri)
    @options    = options
    @stream_uri = stream_uri
    @stream_id  = data[:stream_id]
    @service    = data[:service]
    @cache_id   = data[:cache_id]
    if @options[:file]
      @json_uri = @options[:file]
    else
      @json_uri = data[:json_uri]
    end

    update
  end

  def is_live?
    @is_live
  end

  def inspect
    {
      name: @name,
      viewers: @viewers,
      stream_uri: @stream_uri,
      json_uri: @json_uri,
      cache_id: @cache_id
    }
  end

  def update
    if @options[:file]
      f = File.read(@json_uri)
      response = MultiJson.load(f)
    else
      response = HTTParty.get(@json_uri)
    end

    @response = build(response)
  end

  private

  def build(data)
    raise NotImplementedError
  end

end
