require 'rubygems'
require 'bundler'

Dir["./lib/*.rb"].each { |f| require f }


s = Stream.new(131174)

#s = Stream.new("DanDinh", :twitch)

puts s.is_live? ? "Stream is live!" : "Offline"
puts "#{s.viewers} viewers" if s.is_live?
