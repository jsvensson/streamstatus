class Stream

  class Hashd < Stream

    private

    def build(data)
      @json_uri = "http://api.hashd.tv/v1/stream/#{@stream_id}"
      @username = @stream_id  # Hashd is case-sensitive
      @is_live  = data['live']
      @title    = data['title']
      @viewers  = data['current_viewers']
      @game     = id_to_game(data['game_id'])
    end

    def id_to_game(game_id)
      games = {
        '512130d7e694aa5d34000028' => 'Unknown',
        '510ad4a7fb153d18e20000d1' => 'League of Legends',
        '512ba13fe694aa2da60007ee' => 'Tomb Raider',
      }

      games[game_id]
    end

  end

end
