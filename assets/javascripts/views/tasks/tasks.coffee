jQuery ->
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