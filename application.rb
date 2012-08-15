require 'rubygems'
require 'isolate/now'
require 'sinatra/base'
require 'slim'
require 'json'
require 'sass'
require './medo'

module Medo
  class App < Sinatra::Base
    configure do
      set :medo => Medo.new
    end

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
      settings.medo.tasks.to_json
    end

    post '/tasks' do
      attributes = { 'description' => params['description'] }
      task = settings.medo.add(attributes)
      task.to_json
    end

    delete '/tasks/:id' do
      task = settings.medo.delete params['id']
      task.to_json
    end
  end
end