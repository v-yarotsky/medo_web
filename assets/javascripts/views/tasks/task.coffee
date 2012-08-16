jQuery ->
  class window.TaskView extends Backbone.View
    template: _.template($("#task_template").html())
    tagName: "li"
    className: "task"

    events:
      "click .delete_task": "deleteTask"
      'click .done_task' : 'doneTask'
      'click .reset_task' : 'resetTask'

    deleteTask: (e) =>
      e.preventDefault()
      @model.destroy()
        # wait: true
        # error: -> alert "qqq"
      false

    doneTask: (event) =>
      event.preventDefault()
      @model.save { 'done' : true }
      false

    resetTask: (event) =>
      event.preventDefault()
      @model.save { 'done' : false }
      false

    render: =>
      @$el.html(@template(@model.toJSON()))
      @$el.addClass('done') if @model.get('done')
      @