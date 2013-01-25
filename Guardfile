notification :growl

guard 'rspec' do
	watch('lib/stream.rb') { "spec" }
  watch(%r{^spec/.+_spec\.rb$})  # Watch *_spec.rb in spec/
  watch(%r{^lib/stream_(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }  # lib/*_spec.rb
end
