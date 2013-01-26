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

	it "should be a Stream" do
		twitch_online.should be_a(Stream)
	end

	context "stream is online" do
		it "should initialize" do
			twitch_online.should be_an_instance_of(Stream::Twitch)
		end
	end

	context "stream is offline" do
		it "should initialize" do
			twitch_offline.should be_an_instance_of(Stream::Twitch)
		end
	end

	describe "@cache_id" do
		it "returns cache id" do
			twitch_online.cache_id.should eq("2cfde5ec768165e18983ec0cf6d1dd3f")
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

	describe '#name' do
		context "stream is online" do
			it 'shows stream name' do
				twitch_online.name.should eq("Dan Dinh")
			end
		end

		context "stream is offline" do
			it "returns nil" do
				twitch_offline.name.should be(nil)
			end
		end
	end

	describe '#viewers' do
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

	describe "@stream_uri" do
		context "stream is online" do
			it "returns stream URI" do
				twitch_online.stream_uri.should eq("http://www.twitch.tv/DanDinh")
			end
		end

		context "stream is offline" do
		  it "returns stream URI" do
		  	twitch_offline.stream_uri.should eq("http://www.twitch.tv/DanDinh")
		  end
		end
	end

	describe "@json_uri" do
		context "stream is offline" do
			it "returns JSON URI" do
				twitch_online.json_uri.should eq("http://api.justin.tv/api/stream/list.json?channel=DanDinh")
			end
		end

		context "stream is online" do
		  it "returns JSON URI" do
		  	twitch_online.json_uri.should eq("http://api.justin.tv/api/stream/list.json?channel=DanDinh")
		  end
		end
	end

	describe "#inspect" do
		it "returns a hash" do
			own3d_online.inspect.should be_a(Hash)
		end
		it "returns a string for name" do
			own3d_online.inspect[:name].should be_a(String)
		end
		it "returns a string for stream_uri" do
			own3d_online.inspect[:stream_uri].should be_a(String)
		end
		it "returns a string for json_uri" do
			own3d_online.inspect[:json_uri].should be_a(String)
		end
		it "returns a string for cache_id" do
			own3d_online.inspect[:cache_id].should be_a(String)
		end
		it "returns a fixnum for viewers" do
			own3d_online.inspect[:viewers].should be_a(Fixnum)
		end
	end

end
