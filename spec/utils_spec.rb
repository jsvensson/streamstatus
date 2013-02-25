require 'spec_helper'
require 'stream_utils'

describe Stream::Cache do

  context "with one argument" do
    it "should return MD5 checksum" do
      Stream::Cache.name("foo").should eq("acbd18db4cc2f85cedef654fccc4a4d8")
    end
  end

  context "with two arguments" do
    it "should return MD5 checksum" do
      Stream::Cache.name("foo", "bar").should eq("e5f9ec048d1dbe19c70f720e002f9cb1")
    end
  end

  context "with three arguments" do
    it "should return MD5 checksum" do
      Stream::Cache.name("foo", "bar", "baz").should eq("4c43793687f9a7170a9149ad391cbf70")
    end
  end

end

describe Stream::Service do

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

  context "Justin.tv URI" do
    it "returns hash with stream information" do
      result = {
        :service => :justin,
        :stream_id => "echo5ive",
        :cache_id => "d2c1e3c2d8094bd6247cf63117f2c3f8",
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
        :cache_id => "1f5216b88bcbc28647630500d9946ed2",
        :json_uri => "http://api.justin.tv/api/stream/list.json?channel=echo5ive"
      }
      Stream::Service.normalize("http://www.twitch.tv/echo5ive").should eq(result)
    end
  end

end
