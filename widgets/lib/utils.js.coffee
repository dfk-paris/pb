wApp.utils = {
  shorten: (str, n = 15) ->
    if str && str.length > n
      str.substr(0, n - 1) + '&hellip;'
    else
      str
  in_groups_of: (per_row, array, dummy = null) ->
    result = []
    current = []
    for i in array
      if current.length == per_row
        result.push(current)
        current = []
      current.push(i)
    if current.length > 0
      if dummy
        while current.length < per_row
          current.push(dummy)
      result.push(current)
    result
  to_integer: (value) ->
    if Zepto.isNumeric(value)
      parseInt(value)
    else
      value
  isDevelopment: -> !!window.location.href.match(/localhost:3000/)
  taggedText: (element, text) ->
    e = Zepto(element)
    e.html(text)
    for t in e.find('person')
      t = Zepto(t)
      name = t.html()
      id = t.attr('id')
      newElement = [
        '<a ',
        'href="https://www.wikidata.org/wiki/' + id + '" ',
        'target="_blank" ',
        'role="noopener"',
        '>',
        name,
        '</a>'
      ].join('')
      t.replaceWith(newElement)
  highlightFieldsInElements: (fields, elements) ->
    hl = (match) -> "<mark>#{match}</mark>"

    terms = []
    for n in fields
      if paramValue = wApp.routing.query()[n]
        terms = terms.concat(paramValue.split(/\s+/))
    for e in elements
      for t in terms
        e = Zepto(e)
        e.html e.html().replace(new RegExp("#{t}(?!</mark>)", 'gi'), hl)
  highlightFieldsInElement: (fields, element) ->
    hl = (match) -> "<mark>#{match}</mark>"

    terms = []
    for n in fields
      if paramValue = wApp.routing.query()[n]
        terms = terms.concat(paramValue.split(/\s+/))
    e = Zepto(element)
    for t in terms
      e.html e.html().replace(new RegExp("#{t}(?!</mark>)", 'gi'), hl)
  printElement: (e) ->
    mywindow = window.open('', 'PRINT', 'height=800,width=1024')

    style = "
      .no-print {display: none}
      .w-clearfix {clear: both}

      .location {
        margin-top: 1em;
      }

      hr {
        margin-top: 3rem;
        margin-bottom: 3.5rem;
        border-width: 0;
        border-top: 1px solid #e1e1e1;
      }

      p {
        margin-top: 0px;
      }
      
      pb-media-grid .pb-cell {
        box-sizing: border-box;
        float: left;
        height: 80px;
        width: 80px;
        margin-right: 20px;
        margin-bottom: 20px;
      }

      .pb-list {text-align: center}
      .pb-item {margin-top: 2em}

      .pb-list .pb-caption {margin-top: 0.7em}

      pb-string-value.block-style {
        display: block;
        margin-bottom: 1em;
      }

      pb-text-value, .text-value {
        display: block;
        margin-bottom: 1em;
      }

      .me-separator hr:first-child {
        margin-bottom: 10px;
      }

      .me-separator hr:last-child {
        margin-top: 10px;
      }

      .me-separator:last-child {
        display: none;
      }

      .u-text-right {
        text-align: right;
      }

      .u-text-small {
        font-size: 0.6em;
      }

      .pb-timestamp {
        margin-top: 2em;
      }
    "

    mywindow.document.write('<html><head><title>' + document.title  + '</title>')
    mywindow.document.write('<meta charset="utf-8" />')
    mywindow.document.write('<style type="text/css">' + style + '</style>')
    mywindow.document.write('</head><body>')
    mywindow.document.write(e.innerHTML)
    mywindow.document.write('</body></html>')

    mywindow.document.close() # necessary for IE >= 10
    mywindow.focus() # necessary for IE >= 10*/

    mywindow.print()
    mywindow.close()
}