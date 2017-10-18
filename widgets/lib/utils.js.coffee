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

    mywindow.document.write('<html><head><title>' + document.title  + '</title>')
    mywindow.document.write('<style type="text/css">.no-print {display: none}</style>')
    mywindow.document.write('</head><body>')
    mywindow.document.write(e.innerHTML)
    mywindow.document.write('</body></html>')

    mywindow.document.close() # necessary for IE >= 10
    mywindow.focus() # necessary for IE >= 10*/

    mywindow.print()
    mywindow.close()
}