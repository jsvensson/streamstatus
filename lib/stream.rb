require 'rubygems'
require 'bundler'
Bundler.require :default, (ENV['RACK_ENV'] || "development").to_sym

require 'yaml'

class Stream

  attr_reader :title, :username, :game, :viewers, :service
  attr_reader :stream_uri, :json_uri, :cache_id, :updated_at

  include Comparable

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

  def self.from_yaml(yaml)
    YAML.load(yaml)
  end

  def to_yaml
    YAML.dump(self)
  end

  def is_live?
    !!@is_live
  end

  def inspect
    {
      title: @title,
      username: @username,
      viewers: @viewers,
      game: @game,
      stream_uri: @stream_uri,
      json_uri: @json_uri,
      cache_id: @cache_id,
      service: @service
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
    @updated_at = Time.now
  end

  def age
    (Time.now - @updated_at).to_i
  end

  def <=>(other)
    # Check view count
    return 1 if self.viewers > other.viewers
    return -1 if self.viewers < other.viewers

    # Compare live status
    return 1 if self.is_live? && !other.is_live?
    return -1 if !self.is_live? && other.is_live?

    # By now both streams are offline, sort by name
    return 1 if self.username < other.username
    return -1 if self.username > other.username

    # You know what? If we get this far, let's call them equal.
    return 0
  end

  private

  def build(data)
    raise NotImplementedError
  end

end
