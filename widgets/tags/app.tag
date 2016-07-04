<pb-app>

  <div class="container navigation">
    <div class="u-text-right">
      <a href="/index.html">Liste</a> |
      <a href="/form.html">Eingabe</a>
    </div>
  </div>
  
  <script type="text/coffee">
    self = this

    $.ajaxSettings = $.extend($.ajaxSettings,
      dataType: 'json'
      contentType: 'json'
    )
  </script>

  <style type="text/scss">
    $blue: #1eaedb;

    body {
      padding-bottom: 10rem;
    }

    a {
      cursor: pointer;
    }

    textarea {
      min-height: 15rem;
      resize: none;
    }

    .u-text-right {
      text-align: right;
    }

    .u-text-left {
      text-align: left; 
    }

    .u-text-center {
      text-align: center;
    }

    .pb-thumbnail {
      max-width: 8rem;
      max-height: 8rem;
    }

    .dropzone {
      text-align: center;
      vertical-align: middle;
      border: 3px dashed gray;
      color: gray;
      font-size: 3rem;
    }

    .navigation {
      margin-top: 2rem;
    }

    .buttons {
      white-space: nowrap;

      i {
        padding: 0.5rem;
        color: white;
        background-color: $blue;
        font-size: 2rem;
        border-radius: 0.5rem;
      }
    }
  </style>

  <script type="text/coffee">
    Dropzone.autoDiscover = false
  </script>

</pb-app>