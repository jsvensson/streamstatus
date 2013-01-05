require 'rubygems'
require 'bundler'
Bundler.require :test

require 'streamstatus'

file = {
	online: 'spec/json-tests/twitch-dandinh-online.json',
	offline: 'spec/json-tests/twitch-dandinh-offline.json'
}

describe Stream, '#is_live?' do
	context 'stream is online' do
		it 'returns true' do
			s = Stream.new('DanDinh', :twitch, {file: file[:online]})
			s.is_live?.should be_true
		end
	end

	context 'stream is offline' do
		it 'returns false' do
			s = Stream.new('DanDinh', :twitch, {file: file[:offline]})
			s.is_live?.should be_false
		end
	end
end

describe Stream, '#name' do
	it 'shows stream name' do
		s = Stream.new('DanDinh', :twitch, {file: file[:online]})
		s.name.should eq("Dan Dinh")
	end
end

describe Stream, '#viewers' do
	context 'stream is offline' do
		it 'shows 0 viewers' do
			s = Stream.new('DanDinh', :twitch, {file: file[:offline]})
			s.viewers.should eq(0)
		end
	end

	context 'stream is online' do
		it 'shows >= 1 viewers' do
			stream_online.viewers.should >= 1
		end
	end
end

