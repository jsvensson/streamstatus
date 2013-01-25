require 'httparty'

module StreamCache

	def self.get(key, ttl=settings.cache_ttl)
		if settings.cache.get(key) == nil
			settings.cache.set(key, "foo")
		end
		settings.cache.get(key)
	end

	def self.name(service, name)
		"#{service}-#{name}".downcase
	end

end

class Stream

	attr_reader :name, :viewers, :uri, :cache_id

	def initialize(stream_id, options = {})
		@options = options
		@stream_id = stream_id
		@cache_id = StreamCache.name(self.class, @stream_id)
		if @options[:file]
			@json_uri = @options[:file]
		else
			@json_uri = StreamJsonUri[@service] + @stream_id.to_s
		end

		get_status
	end

	def is_live?
		@is_live
	end

	def to_s
		{
			name: @name,
			viewers: @viewers,
			uri: @uri,
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
