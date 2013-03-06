class Stream

  class Hashd < Stream

    private

    def build(data)
      @json_uri = "http://api.hashd.tv/v1/stream/#{@stream_id}"
      @username = @stream_id  # Hashd is case-sensitive
      @is_live  = data['live']
      @title    = data['title']
      @viewers  = data['current_viewers']
      @game     = nil  # Not in their API
    end

  end

end
