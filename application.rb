require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'slim'
require 'json'
require 'sass'
require 'uuid'

class Task
  attr_reader :id, :attributes

  def initialize(attributes)
    @id, @attributes = UUID.new.generate, attributes
  end

  def to_json(*arguments)
    { 'id' => @id }.merge(attributes).to_json(arguments)
  end
end

class Medo
  FILE = "/home/ermak/.medo-tasks"

  attr_reader :tasks

  def initialize
    @path, @tasks = FILE, []
    JSON.parse(File.read(@path)).each do |task|
      @tasks.push Task.new(task)
    end
  end

  def add(attributes)
    task = Task.new(attributes)
    @tasks.push task
    save_file
    task
  end

  def delete(id)
    @tasks.delete_if { |task| task.id == id.to_i }
    save_file
  end

  private
    def save_file
      medo = []
      @tasks.each { |task| medo.push task.attributes }
      File.open(@path, 'w') do |f|
        f.write medo.to_json
      end
    end
end

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
