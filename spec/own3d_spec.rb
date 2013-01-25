require 'stream'
require 'stream_own3d'

def own3d_online
	Stream::Own3d.new(131174, {file: 'spec/json-tests/own3d-echo5ive-online.json'})
end

def own3d_offline
	Stream::Own3d.new(131174, {file: 'spec/json-tests/own3d-echo5ive-offline.json'})
end

describe Stream do

	it "should be a Stream" do
		own3d_online.should be_a(Stream)
	end

	context "stream is online" do
		it "should initialize" do
			own3d_online.should be_an_instance_of(Stream::Own3d)
		end
	end

	context "stream is offline" do
		it "should initialize" do
			own3d_offline.should be_an_instance_of(Stream::Own3d)
		end
	end

	describe "@cache_id" do
		it "returns cache id" do
			own3d_online.cache_id.should eq("stream::own3d-131174")
		end
	end

	describe "#is_live?" do
		context "stream is online" do
			it "returns true" do
				own3d_online.is_live?.should be_true
			end
		end

		context "stream is offline" do
			it "returns false" do
				own3d_offline.is_live?.should be_false
			end
		end
	end

	describe "#name" do
		context "is online" do
			it "shows stream name" do
				own3d_online.name.should eq("Echo's Adventures")
			end
		end

		context "is offline" do
			it "shows stream name" do
				own3d_offline.name.should eq("Echo's Adventures")
			end
		end
	end

	describe "#viewers" do
		context "stream is offline" do
			it "shows 0 viewers" do
				own3d_offline.viewers.should eq(0)
			end
		end

		context "stream is online" do
			it "shows >= 1 viewers" do
				own3d_online.viewers.should >= 1
			end
			it "shows exact viewer count" do
				own3d_online.viewers.should eq(15)
			end
		end
	end

	describe "@uri" do
		context "stream is offline" do
			it "returns stream URL" do
				own3d_online.uri.should eq("http://www.own3d.tv/Echo5ive/live/131174")
			end
		end

		context "stream is online" do
		  it "returns stream URL" do
		  	own3d_online.uri.should eq("http://www.own3d.tv/Echo5ive/live/131174")
		  end
		end
	end

end
