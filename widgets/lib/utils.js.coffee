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
  printElement: (e) ->
    mywindow = window.open('', 'PRINT', 'height=800,width=1024')

    style = "
      .no-print {display: none}
      .w-clearfix {clear: both}

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

      pb-string-value.block-style {
        display: block;
        margin-bottom: 1em;
      }
    "

    mywindow.document.write('<html><head><title>' + document.title  + '</title>')
    mywindow.document.write('<style type="text/css">' + style + '</style>')
    mywindow.document.write('</head><body>')
    mywindow.document.write(e.innerHTML)
    mywindow.document.write('</body></html>')

    mywindow.document.close() # necessary for IE >= 10
    mywindow.focus() # necessary for IE >= 10*/

    mywindow.print()
    # mywindow.close()
}