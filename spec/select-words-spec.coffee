SelectWords = require '../lib/select-words'
{WorkspaceView} = require 'atom'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "SelectWords", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView()
    activationPromise = atom.packages.activatePackage('select-words')

  describe "when the select-words:next event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.select-words')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'select-words:next'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.select-words')).toExist()
        atom.workspaceView.trigger 'select-words:next'
        expect(atom.workspaceView.find('.select-words')).not.toExist()
