require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'slim'
require 'json'

set :public_folder, File.expand_path('../public', __FILE__)

get '/' do
  slim :index
end

get '/tasks' do
  File.read("/Users/vladimiryarotsky/.medo-tasks")
end

