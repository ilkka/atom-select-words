SelectWordsView = require './select-words-view'

module.exports =
  selectWordsView: null

  activate: (state) ->
    @selectWordsView = new SelectWordsView(state.selectWordsViewState)

  deactivate: ->
    @selectWordsView.destroy()

  serialize: ->
    selectWordsViewState: @selectWordsView.serialize()
