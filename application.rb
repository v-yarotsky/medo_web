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
  @@tasks.to_json
end

post '/tasks' do
  task = { "description" => params["description"], "id" => (@@last_id += 1) }
  @@tasks.push task
  task.to_json
end

delete '/tasks/:id' do
  puts "had: #{@@tasks.size}" + @@tasks.map { |t| t["description"] }.inspect
  @@tasks.delete_if { |t| t["id"] == Integer(params["id"]) }.tap { |t| puts "Now: #{t.size}: " + t.map { |q| q["description"]}.inspect }.to_json
end

private

TASKS_FILE = "/Users/vladimiryarotsky/.medo-tasks.web"

@@last_id = 1

@@tasks = JSON.parse(File.read(TASKS_FILE)).each_with_index do |t, idx|
  t["id"] = @@last_id
  @@last_id += 1
end.to_a

def read_tasks
  JSON.parse(File.read(TASKS_FILE)).each_with_index do |t, idx|
    t[:id] = idx + 1
  end
end

def write_tasks(tasks)
  tasks_to_write = tasks.dup
  tasks_to_write.each { |t| t.delete(:id) }
  File.open(TASKS_FILE, "w") do |f|
    f.write tasks_to_write.to_json
  end
end
