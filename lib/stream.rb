require 'rubygems'
require 'bundler'
Bundler.require :default, (ENV['RACK_ENV'] || "development").to_sym

class Stream

  attr_reader :title, :viewers, :stream_uri, :json_uri, :cache_id

  def initialize(stream_uri, opts = {})
    opts = {
      file: nil,
      update: true
    }.merge(opts)

    data = Stream::Service.normalize(stream_uri)
    @options    = opts
    @stream_uri = stream_uri
    @stream_id  = data[:stream_id]
    @service    = data[:service]
    @cache_id   = data[:cache_id]
    if opts[:file]
      @options[:read_from_file] = true
      @json_uri = opts[:file]
    else
      @json_uri = data[:json_uri]
    end

    update if opts[:update]
  end

  def is_live?
    @is_live
  end

  def inspect
    {
      title: @title,
      username: @username,
      viewers: @viewers,
      stream_uri: @stream_uri,
      json_uri: @json_uri,
      cache_id: @cache_id
    }
  end

  def update
    if @options[:read_from_file]
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
