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

    get '/' do
      slim :index
    end

    get '/tasks' do
      settings.medo.tasks.to_json
    end

    post '/tasks' do
      data = JSON.parse(request.body.read)
      task = settings.medo.add({ 'description' => data['description'] })
      task.to_json
    end

    put '/tasks/:id' do 
      data = JSON.parse(request.body.read)
      task = settings.medo.change(params['id'], { 'done' => data['done'] })
      task.to_json
    end

    delete '/tasks/:id' do
      task = settings.medo.delete params['id']
      task.to_json
    end
  end
end