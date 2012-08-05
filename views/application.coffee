jQuery ->
  class window.Task extends Backbone.Model
    urlRoot: '/tasks'

  class window.Tasks extends Backbone.Collection
    url: '/tasks'
    model: window.Task

  class window.NewTaskView extends Backbone.View
    el: "#task-form"
    events:
      "submit": "createTask"

    createTask: (e) =>
      description = @$el.find("input[name='description']").val()
      e.preventDefault()
      $.post '/tasks', { description: description }, (data) =>
        if data && data.length
          task = JSON.parse(data)
          window.tasks.push(task)
          @el.reset()

  class window.TaskView extends Backbone.View
    template: _.template($("#task_template").html())
    tagName: "li"
    className: "task"

    events:
      "click .delete_task": "deleteTask"

    deleteTask: (e) =>
      e.preventDefault()
      @model.destroy()
        # wait: true
        # error: -> alert "qqq"
      console.log @model
      false

    render: =>
      console.log @model.toJSON()
      @$el.html(@template(@model.toJSON()))
      @

  class window.TasksView extends Backbone.View
    el: "#tasks"

    initialize: (tasks) =>
      @tasks = tasks
      @tasks.bind("reset", @render)
      @tasks.bind("add", @render)
      @tasks.bind("remove", @render)

    render: =>
      @$el.empty()
      for task in @tasks.models
        taskView = new window.TaskView(model: task)
        @$el.append(taskView.render().el)
      @

  window.tasks = new Tasks()
  window.tasks.fetch()

  window.tasksView = new window.TasksView(window.tasks)
  window.newTaskView = new window.NewTaskView()



