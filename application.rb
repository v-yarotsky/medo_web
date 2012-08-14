require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'slim'
require 'json'
require 'sass'

class Task
  attr_reader :id, :attributes

  def initialize(attributes)
    @id, @attributes = Time.now, attributes
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
    task
  end

  def delete(id)
    task = @tasks.delete_if { |task| task.id == id }
  end

  private
    def save_file
      File.open(@path, 'w') do |f|
        f.write @tasks.attributes.to_json
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
