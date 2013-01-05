require 'rubygems'
require 'bundler'
Bundler.require :test

require 'streamstatus'

file = {
	online: 'spec/json-tests/own3d-echo5ive-online.json',
	offline: 'spec/json-tests/own3d-echo5ive-offline.json'
}

stream_online = Stream.new(131174, :own3d, {file: file[:online]})
stream_offline = Stream.new(131174, :own3d, {file: file[:offline]})

describe Stream, "#is_live?" do
	context "stream is online" do
		it "returns true" do
			stream_online.is_live?.should be_true
		end
	end

	context "stream is offline" do
		it "returns false" do
			stream_offline.is_live?.should be_false
		end
	end
end

describe Stream, "#name" do
	context "is online" do
		it "shows stream name" do
			stream_online.name.should eq("Echo's Adventures")
		end
	end

	context "is offline" do
		it "shows stream name" do
			stream_offline.name.should eq("Echo's Adventures")
		end
	end
end

describe Stream, "#viewers" do
	context "stream is offline" do
		it "shows 0 viewers" do
			stream_offline.viewers.should eq(0)
		end
	end

	context "stream is online" do
		it "shows >= 1 viewers" do
			stream_online.viewers.should >= 1
		end
	end
end

describe Stream, "@uri" do
	it "returns stream URL" do
			stream_online.uri.should eq("http://www.own3d.tv/Echo5ive/live/131174")
	end
end
