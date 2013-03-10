require 'spec_helper'
require 'stream'
require 'stream_hashd'

def hashd_online
  Stream::Hashd.new('http://hashd.tv/echo', {file: 'spec/json-tests/hashd-echo-online.json'})
end

def hashd_offline
  Stream::Hashd.new('http://hashd.tv/echo', {file: 'spec/json-tests/hashd-echo-offline.json'})
end

describe Stream::Hashd do

  it 'should be a Stream' do
    hashd_online.should be_a(Stream)
  end

  context 'stream is online' do
    it 'should initialize' do
      hashd_online.should be_an_instance_of(Stream::Hashd)
    end
  end

  context 'stream is offline' do
    it 'should initialize' do
      hashd_offline.should be_an_instance_of(Stream::Hashd)
    end
  end

  describe '@cache_id' do
    it 'returns cache id' do
      hashd_online.cache_id.should eq('888e0717910cef6f29564155f354fb06')
    end
  end

  describe '#is_live?' do
    context 'stream is online' do
      it 'returns true' do
        hashd_online.is_live?.should be_true
      end
    end

    context 'stream is offline' do
      it 'returns false' do
        hashd_offline.is_live?.should be_false
      end
    end
  end

  describe '@title' do
    context 'stream is online' do
      it 'shows stream title' do
        hashd_online.title.should eq('Echo plays stuff')
      end
    end

    context 'stream is offline' do
      it 'returns offline message' do
        hashd_offline.title.should eq('Echo plays stuff')
      end
    end
  end

  describe '@username' do
    context 'stream is online' do
      it 'shows channel username' do
        hashd_online.username.should eq('echo')
      end
    end

    context 'stream is offline' do
      it 'shows channel username' do
        hashd_offline.username.should eq('echo')
      end
    end
  end

  describe '@viewers' do
    context 'stream is offline' do
      it 'shows 0 viewers' do
        hashd_offline.viewers.should eq(0)
      end
    end

    context 'stream is online' do
      it 'shows >= 1 viewers' do
        hashd_online.viewers.should >= 1
      end
      it 'shows exact viewer count' do
        hashd_online.viewers.should eq(1)
      end
    end

  end

  describe '@stream_uri' do
    context 'stream is online' do
      it 'returns stream URI' do
        hashd_online.stream_uri.should eq('http://hashd.tv/echo')
      end
    end

    context 'stream is offline' do
      it 'returns stream URI' do
        hashd_offline.stream_uri.should eq('http://hashd.tv/echo')
      end
    end
  end

  describe '@json_uri' do
    context 'stream is offline' do
      it 'returns JSON URI' do
        hashd_online.json_uri.should eq('http://api.hashd.tv/v1/stream/echo')
      end
    end

    context 'stream is online' do
      it 'returns JSON URI' do
        hashd_online.json_uri.should eq('http://api.hashd.tv/v1/stream/echo')
      end
    end
  end

  describe '#inspect' do
    it 'returns a hash' do
      hashd_online.inspect.should be_a(Hash)
    end
    it 'returns a string for username' do
      hashd_online.inspect[:username].should be_a(String)
    end
    it 'returns a string for title' do
      hashd_online.inspect[:title].should be_a(String)
    end
    it 'returns a string for stream_uri' do
      hashd_online.inspect[:stream_uri].should be_a(String)
    end
    it 'returns a string for json_uri' do
      hashd_online.inspect[:json_uri].should be_a(String)
    end
    it 'returns a string for cache_id' do
      hashd_online.inspect[:cache_id].should be_a(String)
    end
    it 'returns a fixnum for viewers' do
      hashd_online.inspect[:viewers].should be_a(Fixnum)
    end
  end

  describe '#<=>' do
    it 'shows online > offline' do
      hashd_online.should be > hashd_offline
    end
    it 'shows offline < online' do
      hashd_offline.should be < hashd_online
    end
    it 'shows online == online' do
      hashd_online.should be == hashd_online
    end
    it 'shows offline == offline' do
      hashd_offline.should be == hashd_offline
    end
  end

  describe '#to_yaml' do
    it 'spews YAML' do
      hashd_online.to_yaml.should be_a(String)
    end
  end

  describe '::from_yaml' do
    before do
      @yaml = hashd_online.to_yaml
      @yaml_object = Stream::Hashd.from_yaml(@yaml)
    end

    it 'should be a stream' do
      @yaml_object.should be_a(Stream)
    end

    it 'should initialize' do
      @yaml_object.should be_an_instance_of(Stream::Hashd)
    end

    it 'should have a stream URI' do
      @yaml_object.stream_uri.should eq(hashd_online.stream_uri)
    end

    it 'should have a username' do
      @yaml_object.username.should eq('echo')
    end

    it 'should be equal to other object' do
      @yaml_object.should eq(hashd_online)
    end
  end

end
