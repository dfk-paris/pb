<pb-text-value>

  <div class="text-value" if={opts.riotValue}>
    <em>{opts.label}</em>
    <p></p>
  </div>

  <script type="text/javascript">
    var tag = this;

    tag.on('mount', function() {
      updateText()
    })

    tag.on('updated', function() {
      updateText()
    });

    var updateText = function() {
      var target = Zepto(tag.root).find('p');
      target.html(opts.riotValue);
      var peopleTags = target.find('person');
      for (var i = 0; i < peopleTags.length; i++) {
        var t = Zepto(peopleTags[i]);
        name = t.html();
        id = t.attr('id');
        var newElement = [
          '<a ',
          'href="https://www.wikidata.org/wiki/' + id + '" ',
          'target="_blank" ',
          'role="noopener"',
          '>',
          name,
          '</a>'
        ].join('');
        t.replaceWith(newElement);
      }
    }
  </script>

</pb-text-value>