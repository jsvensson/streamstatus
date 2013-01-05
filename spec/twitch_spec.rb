require 'rubygems'
require 'bundler'
Bundler.require :test

Dir["./lib/*.rb"].each { |f| require f }

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
		it 'shows 6633 viewers' do
			s = Stream.new(131174, :twitch, {file: file[:online]})
			s.viewers.should eq(6633)
		end
	end
end

