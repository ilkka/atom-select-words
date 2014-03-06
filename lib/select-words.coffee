#SelectWordsView = require './select-words-view'

module.exports =
  #selectWordsView: null

  activate: (state) ->
    atom.workspaceView.eachPane (pane) ->
      pane.command 'select-words:next', ->
        #@selectWordsView = new SelectWordsView(state.selectWordsViewState)
        editor = atom.workspace.getActiveEditor()
        editor.selectWord() if editor.getSelectedBufferRange().isEmpty()
        word = editor.getSelectedText()
        editor.buffer.scan new RegExp("\\b#{word}\\b"), (obj) ->
          console.log obj
          editor.addSelectionForBufferRange(obj.range)
          obj.stop()

  deactivate: ->
    #@selectWordsView.destroy()

  serialize: ->
    #selectWordsViewState: @selectWordsView.serialize()
