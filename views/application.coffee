jQuery ->
  class window.Task extends Backbone.Model
    urlRoot: '/tasks'

  class window.Tasks extends Backbone.Collection
    url: '/tasks'
    model: window.Task

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

    initialize: =>
      @tasks = new window.Tasks()
      @tasks.fetch()
      @tasks.bind("reset", @render)

    render: =>
      for task in @tasks.models
        taskView = new window.TaskView(model: task)
        @$el.append(taskView.render().el)
      @
      @$el.find('li.task:even').addClass('odd')

  new window.TasksView()



