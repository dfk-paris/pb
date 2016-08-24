riot.tag2('pb-se-editor', '<h1 show="{item.title}">Objekt \'{item.title}\' bearbeiten</h1> <h1 show="{!item}">Objekt erstellen</h1> <hr> <form onsubmit="{submit}"> <div class="row"> <div class="six columns"> <pb-input label="Objektbezeichnung" name="title" value="{item.title}" errors="{errors.title}"></pb-input> <pb-input label="Fortlaufende Nummer" name="sequence" value="{item.sequence}" errors="{errors.sequence}"></pb-input> </div> <div class="six columns"> <pb-textarea label="Inventarnummern" name="inventory_id_list" value="{item.inventory_ids.join(\', \')}" errors="{errors.inventory_ids}"></pb-textarea> </div> </div> <hr> <div class="row"> <div class="six columns"> <pb-autocomplete label="Hersteller / Künstler" name="creator" value="{item.creator}"></pb-autocomplete> <pb-autocomplete label="Material" name="material" value="{item.material}"></pb-autocomplete> <pb-autocomplete label="Markierungen" name="markings" value="{item.markings}"></pb-autocomplete> </div> <div class="six columns"> <pb-autocomplete label="Herstellungsort" name="location" value="{item.location}"></pb-autocomplete> <pb-input label="Datum" name="dating" value="{item.dating}"></pb-input> </div> </div> <hr> <div class="row"> <div class="four columns"> <pb-input label="Höhe ohne Sockel (in cm)" name="height" value="{item.height}"></pb-input> <pb-input label="Höhe mit Sockel (in cm)" name="height_with_socket" value="{item.height_with_socket}"></pb-input> <pb-input label="Gewicht (in kg)" name="weight" value="{item.weight}"></pb-input> </div> <div class="four columns"> <pb-input label="Breite ohne Sockel (in cm)" name="width" value="{item.width}"></pb-input> <pb-input label="Breite mit Sockel (in cm)" name="width_with_socket" value="{item.width_with_socket}"></pb-input> <pb-input label="Durchmesser (in cm)" name="diameter" value="{item.diameter}"></pb-input> </div> <div class="four columns"> <pb-input label="Tiefe ohne Sockel (in cm)" name="depth" value="{item.depth}"></pb-input> <pb-input label="Tiefe mit Sockel (in cm)" name="depth_with_socket" value="{item.depth_with_socket}"></pb-input> </div> </div> <hr> <pb-textarea label="Restaurierungen" name="restaurations" value="{item.restaurations}"></pb-textarea> <hr> <pb-media-dropzone media="{item.media}" sub-entry-id="{opts.id}"></pb-media-dropzone> <hr> <div class="u-text-right"> <input type="submit" class="button-primary" value="Speichern"> <input type="reset" class="button" value="Abbrechen"> </div> </form>', '', '', function(opts) {
var form_data, self;

self = this;

self.on('mount', function() {
  var x;
  x = wApp.bus.on('pb-load-data', function() {
    return self.load_data();
  });
  return self.load_data();
});

self.load_data = function() {
  console.log('loading');
  if (self.opts.id) {
    return $.ajax({
      type: 'get',
      url: "/api/ses/" + self.opts.id,
      success: function(data) {
        console.log(data);
        self.item = data;
        return self.update();
      }
    });
  }
};

form_data = function() {
  var e, element, i, len, ref, result;
  result = {};
  ref = $(self.root).find("[name]");
  for (i = 0, len = ref.length; i < len; i++) {
    element = ref[i];
    e = $(element);
    result[e.attr('name')] = e.val();
  }
  result.main_entry_id = self.opts.main_entry_id;
  return result;
};

self.submit = function(event) {
  event.preventDefault();
  if (self.opts.id) {
    return $.ajax({
      type: 'put',
      url: "/api/ses/" + self.opts.id,
      data: JSON.stringify({
        sub_entry: form_data()
      }),
      success: function(data) {},
      error: function(request) {
        return console.log(JSON.parse(request.response));
      }
    });
  } else {
    return $.ajax({
      type: 'post',
      url: "/api/ses",
      data: JSON.stringify({
        sub_entry: form_data()
      }),
      success: function(data) {
        console.log(data);
        self.errors = void 0;
        return riot.route('/mes');
      },
      error: function(request) {
        var data;
        data = JSON.parse(request.response);
        console.log(data);
        return self.errors = data.errors;
      },
      complete: function() {
        return self.update();
      }
    });
  }
};
});