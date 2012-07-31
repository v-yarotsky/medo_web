require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'slim'
require 'json'
require 'sass'

get '/application.css' do
  content_type 'text/css', charset: 'utf-8'
  scss :application
end

get '/application.js' do
  content_type 'text/javascript', charset: 'utf-8'
  coffee :application
end

get '/' do
  slim :index
end

get '/tasks' do
  File.read("/Users/vladimiryarotsky/.medo-tasks")
end

