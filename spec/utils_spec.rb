require 'spec_helper'
require 'stream_utils'

describe Stream::Cache do

	it "should return MD5 checksum" do
		Stream::Cache.name("foo", "bar").should eq("e5f9ec048d1dbe19c70f720e002f9cb1")
	end

end

describe Stream::Service do

	context "Own3d.tv hash access" do
		it "returns Own3d.tv stream id" do
			test = Stream::Service.normalize("http://www.own3d.tv/Echo5ive/live/131174")
			test[:stream_id].should eq("131174")
		end

		it "returns Own3d.tv JSON URI" do
			test = Stream::Service.normalize("http://www.own3d.tv/Echo5ive/live/131174")
			test[:json_uri].should eq("http://api.own3d.tv/rest/live/status.json?liveid=131174")
		end

		it "returns Own3d.tv service name" do
			test = Stream::Service.normalize("http://www.own3d.tv/Echo5ive/live/131174")
			test[:service].should eq(:own3d)
		end
	end

	context "Twitch.tv hash access" do
		it "returns Twitch.tv stream id" do
			test = Stream::Service.normalize("http://www.twitch.tv/echo5ive")
			test[:stream_id].should eq("echo5ive")
		end

		it "returns Twitch.tv JSON URI" do
			test = Stream::Service.normalize("http://www.twitch.tv/echo5ive")
			test[:json_uri].should eq("http://api.justin.tv/api/stream/list.json?channel=echo5ive")
		end

		it "returns Twitch.tv service name" do
			test = Stream::Service.normalize("http://www.twitch.tv/echo5ive")
			test[:service].should eq(:twitch)
		end
	end


	context "Own3d.tv URI" do
		it "returns hash with stream information" do
			result = {
				:service => :own3d,
				:stream_id => "131174",
				:json_uri => "http://api.own3d.tv/rest/live/status.json?liveid=131174"
			}
			Stream::Service.normalize("http://www.own3d.tv/Echo5ive/live/131174").should eq(result)
		end
	end

	context "Justin.tv URI" do
		it "returns hash with stream information" do
			result = {
				:service => :justin,
				:stream_id => "echo5ive",
				:json_uri => "http://api.justin.tv/api/stream/list.json?channel=echo5ive"
			}
			Stream::Service.normalize("http://www.justin.tv/echo5ive").should eq(result)
		end
	end

	context "Twitch.tv URI" do
		it "returns hash with stream information" do
			result = {
				:service => :twitch,
				:stream_id => "echo5ive",
				:json_uri => "http://api.justin.tv/api/stream/list.json?channel=echo5ive"
			}
			Stream::Service.normalize("http://www.twitch.tv/echo5ive").should eq(result)
		end
	end


end
