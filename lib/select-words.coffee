module.exports =
  activate: (state) ->
    atom.workspaceView.eachPane (pane) ->
      pane.command 'select-words:next', ->
        editor = atom.workspace.getActiveEditor()
        if editor.getSelectedBufferRange().isEmpty()
          editor.selectWord()
        else
          word = editor.getSelectedText()
          wordrange = editor.getSelectedBufferRange()
          regex = new RegExp("\\b#{word}\\b")
          range = [wordrange.end, editor.buffer.getEndPosition()]
          numSelectionsBefore = editor.getSelectedBufferRanges().length
          editor.buffer.scanInRange(regex, range, (obj) ->
            editor.addSelectionForBufferRange(obj.range)
            obj.stop())
          numSelectionsAfter = editor.getSelectedBufferRanges().length
          if numSelectionsAfter == numSelectionsBefore
            range = [editor.buffer.getFirstPosition(), wordrange.start]
            editor.buffer.scanInRange(regex, range, (obj) ->
              editor.addSelectionForBufferRange(obj.range)
              obj.stop())
      pane.command 'select-words:all', ->
        editor = atom.workspace.getActiveEditor()
        if editor.getSelectedBufferRange().isEmpty()
          editor.selectWord()
        else
          word = editor.getSelectedText()
          regex = new RegExp("\\b#{word}\\b", "g")
          editor.buffer.scan(regex, (obj) ->
            editor.addSelectionForBufferRange(obj.range))
