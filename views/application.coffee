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

  new window.TasksView()



