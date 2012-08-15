#= require libs/jquery-1.7.2
#= require libs/underscore
#= require libs/json2
#= require libs/backbone

#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

jQuery ->
  window.tasks = new Tasks()
  window.tasks.fetch()

  window.tasksView = new window.TasksView(window.tasks)
  window.newTaskView = new window.NewTaskView()



