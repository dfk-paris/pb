<pb-button>

  <a href={opts.href}>
    <i class="fa fa-{opts.icon}"></i>
    {opts.label}
  </a>

  <style type="text/scss">
    @import "widgets/vars.scss";

    pb-button, [data-is=pb-button] {
      font-size: 1rem;
      padding-left: 0.5rem;

      a {
        color: white;
        background-color: $blue;
        border-radius: 0.3rem;
        padding: 0.5rem;
        text-decoration: none;
      }

      a:hover {
        color: white;
        background-color: lighten($blue, 20)
      }
    }
  </style>

</pb-button>