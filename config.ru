require './application.rb'
require 'sprockets'

map '/assets' do
	environment = Sprockets::Environment.new
	environment.append_path './assets/javascripts'
	environment.append_path './assets/stylesheets'
	run environment
end

map '/' do
	run Medo::App
end