require 'spec_helper'
require 'stream'
require 'stream_twitch'

def twitch_online
	Stream::Twitch.new('DanDinh', {file: 'spec/json-tests/twitch-dandinh-online.json'})
end

def twitch_offline
	Stream::Twitch.new('DanDinh', {file: 'spec/json-tests/twitch-dandinh-offline.json'})
end

describe Stream do

	it "should be a Stream" do
		own3d_online.should be_a(Stream)
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
			twitch_online.cache_id.should eq("7963899928cf25a77cca7f134307ed6c")
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
			it "returns stream URL" do
					twitch_online.stream_uri.should eq("http://www.justin.tv/dandinh")
			end
		end

		context "stream is offline" do
		  it "returns nil goddamnit Twitch" do
		  		twitch_offline.stream_uri.should be(nil)
		  end
		end
	end

end
