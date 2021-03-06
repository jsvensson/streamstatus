require 'spec_helper'
require 'stream'
require 'stream_twitch'

def twitch_online
  Stream::Twitch.new('http://www.twitch.tv/DanDinh', {file: 'spec/json-tests/twitch-dandinh-online.json'})
end

def twitch_offline
  Stream::Twitch.new('http://www.twitch.tv/DanDinh', {file: 'spec/json-tests/twitch-dandinh-offline.json'})
end

describe Stream::Twitch do

  it 'should be a Stream' do
    twitch_online.should be_a(Stream)
  end

  context 'stream is online' do
    it 'should initialize' do
      twitch_online.should be_an_instance_of(Stream::Twitch)
    end
  end

  context 'stream is offline' do
    it 'should initialize' do
      twitch_offline.should be_an_instance_of(Stream::Twitch)
    end
  end

  describe '@cache_id' do
    it 'returns cache id' do
      twitch_online.cache_id.should eq('8b217e650c7ce996a88e40615373c986')
    end
  end

  describe '#is_live?' do
    context 'stream is online' do
      it 'returns true' do
        twitch_online.is_live?.should be_true
      end
    end

    context 'stream is offline' do
      it 'returns false' do
        twitch_offline.is_live?.should be_false
      end
    end
  end

  describe '@title' do
    context 'stream is online' do
      it 'shows stream title' do
        twitch_online.title.should eq('Dan Dinh')
      end
    end

    context 'stream is offline' do
      it 'returns nil' do
        twitch_offline.title.should be(nil)
      end
    end
  end

  describe '@username' do
    context 'stream is online' do
      it 'shows channel username' do
        twitch_online.username.should eq('dandinh')
      end
    end

    context 'stream is offline' do
      it 'shows channel username' do
        twitch_offline.username.should eq('dandinh')
      end
    end
  end

  describe '@viewers' do
    context 'stream is offline' do
      it 'shows 0 viewers' do
        twitch_offline.viewers.should eq(0)
      end
    end

    context 'stream is online' do
      it 'shows >= 1 viewers' do
        twitch_online.viewers.should >= 1
      end
      it 'shows exact viewer count' do
        twitch_online.viewers.should eq(6633)
      end
    end

  end

  describe '@stream_uri' do
    context 'stream is online' do
      it 'returns stream URI' do
        twitch_online.stream_uri.should eq('http://www.twitch.tv/DanDinh')
      end
    end

    context 'stream is offline' do
      it 'returns stream URI' do
        twitch_offline.stream_uri.should eq('http://www.twitch.tv/DanDinh')
      end
    end
  end

  describe '@json_uri' do
    context 'stream is offline' do
      it 'returns JSON URI' do
        twitch_online.json_uri.should eq('http://api.justin.tv/api/stream/list.json?channel=DanDinh')
      end
    end

    context 'stream is online' do
      it 'returns JSON URI' do
        twitch_online.json_uri.should eq('http://api.justin.tv/api/stream/list.json?channel=DanDinh')
      end
    end
  end

  describe '#inspect' do
    it 'returns a hash' do
      twitch_online.inspect.should be_a(Hash)
    end
    it 'returns a string for username' do
      twitch_online.inspect[:username].should be_a(String)
    end
    it 'returns a string for title' do
      twitch_online.inspect[:title].should be_a(String)
    end
    it 'returns a string for stream_uri' do
      twitch_online.inspect[:stream_uri].should be_a(String)
    end
    it 'returns a string for json_uri' do
      twitch_online.inspect[:json_uri].should be_a(String)
    end
    it 'returns a string for cache_id' do
      twitch_online.inspect[:cache_id].should be_a(String)
    end
    it 'returns a fixnum for viewers' do
      twitch_online.inspect[:viewers].should be_a(Fixnum)
    end
  end

  describe '#<=>' do
    it 'shows online > offline' do
      twitch_online.should be > twitch_offline
    end
    it 'shows offline < online' do
      twitch_offline.should be < twitch_online
    end
    it 'shows online == online' do
      twitch_online.should be == twitch_online
    end
    it 'shows offline == offline' do
      twitch_offline.should be == twitch_offline
    end
  end

  describe '#to_yaml' do
    it 'spews YAML' do
      twitch_online.to_yaml.should be_a(String)
    end
  end

  describe '::from_yaml' do
    before do
      @yaml = twitch_online.to_yaml
      @yaml_object = Stream::Hashd.from_yaml(@yaml)
    end

    it 'should be a stream' do
      @yaml_object.should be_a(Stream)
    end

    it 'should initialize' do
      @yaml_object.should be_an_instance_of(Stream::Twitch)
    end

    it 'should have a stream URI' do
      @yaml_object.stream_uri.should eq(twitch_online.stream_uri)
    end

    it 'should have a username' do
      @yaml_object.username.should eq('dandinh')
    end

    it 'should be equal to other object' do
      @yaml_object.should eq(twitch_online)
    end
  end

  describe '@updated_at' do
    it 'should be a Time' do
      hashd_online.updated_at.should be_a(Time)
    end
  end

  describe '#age' do
    it 'should return a Fixnum' do
      hashd_online.age.should be_a(Fixnum)
    end

    it 'should be >= 0' do
      hashd_online.age.should be >= 0
    end
  end

end
