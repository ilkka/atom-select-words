module.exports =
  activate: (state) ->
    atom.workspaceView.eachPane (pane) ->
      pane.command 'select-words:next', ->
        editor = atom.workspace.getActiveEditor()
        editor.selectWord() if editor.getSelectedBufferRange().isEmpty()
        word = editor.getSelectedText()
        wordrange = editor.getSelectedBufferRange()
        regex = new RegExp("\\b#{word}\\b")
        range = [wordrange.end, editor.buffer.getEndPosition()]
        console.log word, wordrange, regex, range
        editor.buffer.scanInRange(regex, range, (obj) ->
          console.log obj
          editor.addSelectionForBufferRange(obj.range)
          obj.stop())
