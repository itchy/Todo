window.Todo =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Todo.Routers.Items()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Todo.init()
