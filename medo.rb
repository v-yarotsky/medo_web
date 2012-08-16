require 'uuid'

module Medo
  class Task
    attr_reader :id
    attr_accessor :attributes

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

    def change(id, attributes)
      task = @tasks.select { |task| task.id.to_s == id.to_s }.first
      attributes.each { |key, value| task.attributes[key] = value }
    end

    def delete(id)
      @tasks.delete_if { |task| task.id.to_s == id.to_s }
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
end