class window.Task extends Backbone.Model
  urlRoot: '/tasks'
  defaults:
  	description: null
  	done: false