<pb-person>

  <virtual if={wikidataFor(opts.name)}>
    <a
      href="https://www.wikidata.org/wiki/{wikidataFor(opts.name)}"
      target="_blank"
      rel="noopener"
    >
      {opts.name}
    </a>
  </virtual>
  <virtual if={!wikidataFor(opts.name)}>
    {opts.name}
  </virtual>

  <script type="text/javascript">
    var tag = this;

    tag.wikidataFor = function(name) {
      return wApp.data.people[name];
    }
  </script>

</pb-person>