jQuery ->
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