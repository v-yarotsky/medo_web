jQuery ->
  class window.TasksView extends Backbone.View
    el: "#content"
    events:
      'submit #task-form': 'createTask'

    initialize: (tasks) =>
      @container = @$('#tasks')
      @form = @$('form#task-form')

      @tasks = new window.Tasks()
      @tasks.bind("reset", @render)
      @tasks.bind("add", @render)
      @tasks.bind("remove", @render)
      @tasks.bind("change", @render)

      @tasks.fetch()

    render: =>
      @container.empty()
      for task in @tasks.models
        taskView = new window.TaskView(model: task)
        @container.append(taskView.render().el)
      @

    createTask: (event) =>
      event.preventDefault()
      description = @form.find('input#task-description').val()
      task = new window.Task({ 'description' : description })
      task.save()
      @tasks.push(task)
      false