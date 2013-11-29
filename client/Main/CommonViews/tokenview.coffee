class TokenView extends JView
  constructor: (options = {}, data) ->
    options.tagName    or= "span"
    options.cssClass     = KD.utils.curry "token", options.cssClass
    options.attributes or= {}
    options.attributes.contenteditable = no
    options.itemClass  or= KDCustomHTMLView
    options.type       or= "generic"
    super options, data

    @item = new options.itemClass {}, data

  getKey: ->
    return @getData().getId()

  encodeValue: ->
    return   "" unless data = @getData()
    {prefix} = @getOptions()
    return   "|#{prefix}:#{data.bongo_.constructorName}:#{data.getId()}|"

  pistachio: ->
    "{{> @item}}"
