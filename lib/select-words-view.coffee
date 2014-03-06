{View} = require 'atom'

module.exports =
class SelectWordsView extends View
  @content: ->
    @div class: 'select-words overlay from-top', =>
      @div "The SelectWords package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "select-words:next", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "SelectWordsView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
