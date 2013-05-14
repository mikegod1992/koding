class AceFindAndReplaceView extends JView

  constructor: (options = {}, data) ->

    options.cssClass = "ace-find-replace-view"

    super options, data

    @mode             = null
    @lastViewHeight   = 0
    @isFoundSomething = no

    @findInput = new KDHitEnterInputView
      type         : "text"
      validate     :
        rules      :
          required : yes
      keyup        : @bindSpecialKeys "find"
      callback     : => @findNext()

    @findNextButton = new KDButtonView
      cssClass     : "editor-button"
      title        : "Find Next"
      callback     : => @findNext()

    @findPrevButton = new KDButtonView
      cssClass     : "editor-button"
      title        : "Find Prev"
      callback     : => @findPrev()

    @replaceInput = new KDHitEnterInputView
      type         : "text"
      cssClass     : "ace-replace-input"
      validate     :
        rules      :
          required : yes
      keyup        : @bindSpecialKeys "replace"
      callback     : => @replace()

    @replaceButton = new KDButtonView
      title        : "Replace"
      cssClass     : "ace-replace-button clean-gray"
      callback     : => @replace()

    @replaceAllButton = new KDButtonView
      title        : "Replace All"
      cssClass     : "ace-replace-button clean-gray"
      callback     : => @replaceAll()

    @closeButton = new KDCustomHTMLView
      tagName      : "span"
      cssClass     : "close-icon"
      click        : => @close()

    @choices = new KDMultipleChoice
      cssClass     : "clean-gray editor-button control-button"
      labels       : ["case-sensitive", "whole-word", "regex"]
      multiple     : yes

  bindSpecialKeys: (input) ->
    "esc"           : (e) => @close()
    "super+f"       : (e) =>
      e.preventDefault()
      @setViewHeight no
    "super+shift+f" : (e) =>
      e.preventDefault()
      @setViewHeight yes
    "shift+enter"   : (e) =>
      @findPrev() if input is "find"

  close: ->
    @hide()
    @resizeAceEditor 0
    @findInput.setValue    ""
    @replaceInput.setValue ""
    @emit "FindAndReplaceViewClosed"

  setViewHeight: (isReplaceMode) ->
    height = if isReplaceMode then 60 else 32
    @$().css { height }
    @resizeAceEditor height
    @show()
    @isFoundSomething = no

  resizeAceEditor: (height) ->
    {ace} = @getDelegate()
    ace.setHeight ace.getHeight() + @lastHeightTakenFromAce - height
    ace.editor.resize yes
    @lastHeightTakenFromAce = height

  lastHeightTakenFromAce: 0

  setTextIntoFindInput: (text) ->
    return @findInput.setFocus() if text.indexOf("\n") > 0 or text.length is 0
    @findInput.setValue text
    @findInput.setFocus()

  getSearchOptions: ->
    @selections   = @choices.getValue()

    caseSensitive : @selections.indexOf("case-sensitive") > -1
    wholeWord     : @selections.indexOf("whole-word") > -1
    regExp        : @selections.indexOf("regex") > -1
    backwards     : no

  findNext: -> @findHelper "next"

  findPrev: -> @findHelper "prev"

  findHelper: (direction) ->
    keyword = @findInput.getValue()
    return unless keyword
    methodName = if direction is "prev" then "findPrevious" else "find"
    @getDelegate().ace.editor[methodName] @findInput.getValue(), @getSearchOptions()
    @findInput.focus()
    @isFoundSomething = yes

  replace:    -> @replaceHelper no

  replaceAll: -> @replaceHelper yes

  replaceHelper: (doReplaceAll) ->
    findKeyword    = @findInput.getValue()
    replaceKeyword = @replaceInput.getValue()
    return unless findKeyword or replaceKeyword

    {editor}   = @getDelegate().ace
    methodName = if doReplaceAll then "replaceAll" else "replace"

    @findNext() unless @isFoundSomething
    editor[methodName] replaceKeyword

  pistachio: ->
    """
      <div class="ace-find-replace-settings">
        {{> @choices}}
      </div>
      <div class="ace-find-replace-inputs">
        {{> @findInput}}
        {{> @replaceInput}}
      </div>
      <div class="ace-find-replace-buttons">
        {{> @findNextButton}}
        {{> @findPrevButton}}
        {{> @replaceButton}}
        {{> @replaceAllButton}}
      </div>
      {{> @closeButton}}
    """