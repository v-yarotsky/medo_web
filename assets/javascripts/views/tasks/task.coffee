jQuery ->
  class window.TaskView extends Backbone.View
    template: _.template($("#task_template").html())
    tagName: "li"
    className: "task"

    events:
      "click .delete_task": "deleteTask"
      'click .done_task' : 'doneTask'

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

    render: =>
      @$el.html(@template(@model.toJSON()))
      @$el.addClass('done') if @model.get('done')
      @