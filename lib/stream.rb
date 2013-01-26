require 'rubygems'
require 'bundler'
Bundler.require :default, (ENV['RACK_ENV'] || "development").to_sym

class Stream

	attr_reader :name, :viewers, :stream_uri, :json_uri, :cache_id

	def initialize(stream_uri, options = {})
		@options    = options
		@stream_uri = stream_uri
		@stream_id  = Stream::Service.normalize(stream_uri)[:stream_id]
		@service    = Stream::Service.normalize(stream_uri)[:service]
		@cache_id   = Stream::Cache.name(self.class, @stream_id)
		if @options[:file]
			@json_uri = @options[:file]
		else
			@json_uri = Stream::Service.normalize(stream_uri)[:json_uri]
		end

		get_status
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

	private

	def get_status
		if @options[:file]
			f = File.read(@json_uri)
			response = MultiJson.load(f)
		else
			response = HTTParty.get(@json_uri)
		end

		@response = build(response)
	end

	def build(data)
		raise NotImplementedError
	end

end
