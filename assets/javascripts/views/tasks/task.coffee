jQuery ->
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
        false

      render: =>
        @$el.html(@template(@model.toJSON()))
        @