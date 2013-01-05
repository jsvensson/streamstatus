require 'rubygems'
require 'bundler'
Bundler.require :test

require 'streamstatus'

file = {
	online: 'spec/json-tests/twitch-dandinh-online.json',
	offline: 'spec/json-tests/twitch-dandinh-offline.json'
}

stream_online = Stream.new('DanDinh', :twitch, {file: file[:online]})
stream_offline = Stream.new('DanDinh', :twitch, {file: file[:offline]})

describe Stream, '#is_live?' do
	context 'stream is online' do
		it 'returns true' do
			stream_online.is_live?.should be_true
		end
	end

	context 'stream is offline' do
		it 'returns false' do
			stream_offline.is_live?.should be_false
		end
	end
end

describe Stream, '#name' do
	context "stream is online" do
		it 'shows stream name' do
			stream_online.name.should eq("Dan Dinh")
		end
	end

	context "stream is offline" do
		it "returns nil" do
			stream_offline.name.should be(nil)
		end
	end
end

describe Stream, '#viewers' do
	context 'stream is offline' do
		it 'shows 0 viewers' do
			stream_offline.viewers.should eq(0)
		end
	end

	context 'stream is online' do
		it 'shows >= 1 viewers' do
			stream_online.viewers.should >= 1
		end
		it 'shows exact viewer count' do
			stream_online.viewers.should eq(6633)
		end
	end

end

describe Stream, "@uri" do
	context "stream is online" do
		it "returns stream URL" do
				stream_online.uri.should eq("http://www.justin.tv/dandinh")
		end
	end

	context "stream is offline" do
	  it "returns nil goddamnit Twitch" do
	  		stream_offline.uri.should be(nil)
	  end
	end
end
