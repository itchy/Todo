class Todo.Views.ItemsIndex extends Backbone.View

  template: JST['items/index']
  
  events: 
    'submit #new_item': 'createEntry'
  
  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @render, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendItem)
    this
    
  appendItem: (item) ->
    view = new Todo.Views.Item(model: item)
    $('#items').append(view.render().el)
    
  createEntry: (event) ->
    event.preventDefault()
    @collection.create description: $("#new_item_description").val()