class Todo.Views.Item extends Backbone.View
  template: JST['items/item']
  tagName: 'li'

  render: ->
    $(@el).html(@template(item: @model))
    this
    