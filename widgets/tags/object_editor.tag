<pb-object-editor>

  <h1>Objekt 'Kerzenständer' bearbeiten</h1>

  <hr />

  <form>
    <div class="row">
      <div class="six columns">
        <label for="pb_form_object_name_de">Objektbezeichnung</label>
        <input
          class="u-full-width"
          type="text"
          name="name"
          id="pb_form_object_name_de"
        />
      </div>
      <div class="six columns">
        <label for="pb_form_object_name_fr">französische Übersetzung</label>
        <input
          class="u-full-width"
          type="text"
          name="name"
          id="pb_form_object_name_fr"
        />
      </div>
    </div>

    <label for="pb_form_object_location">Aufstellungsort</label>
    <div class="row">
      <div class="six columns">
        <pb-locations-select />
      </div>
      <div class="six columns">
        {tags['pb-locations-select'].french_value()}
      </div>
    </div>

    <label for="pb_form_object_people">Hersteller / Künstler</label>
    <div class="row">
      <div class="six columns">
        <pb-people-autocomplete />
      </div>
    </div>

    <hr />

    <label for="pb_form_object_people">Inventarbezeichnung</label>
    <div class="row">
      <div class="six columns">
        <input
          class="u-full-width"
          type="text"
          name="inventory"
          id="pb_form_object_inventory"
        />
      </div>
    </div>

    <label for="pb_form_object_account_number">Konto-Nr.</label>
    <div class="row">
      <div class="six columns">
        <input
          class="u-full-width"
          type="text"
          name="account_number"
          id="pb_form_object_account_number"
        />
      </div>
    </div>

    <hr />

    <label for="pb_form_object_date">Datum</label>
    <div class="row">
      <div class="six columns">
        <input
          class="u-full-width"
          type="text"
          name="date"
          id="pb_form_object_date"
        />
      </div>
    </div>

    <div class="row">
      <div class="six columns">
        <label for="pb_form_object_creation_location_de">Entstehungsort</label>
        <input
          class="u-full-width"
          type="text"
          name="date"
          id="pb_form_object_creation_location_de"
        />
      </div>
      <div class="six columns">
        <label for="pb_form_object_creation_location_fr">französische Übersetzung</label>
        <input
          class="u-full-width"
          type="text"
          name="name"
          id="pb_form_object_creation_location_fr"
        />
      </div>
    </div>

    <div class="row">
      <div class="six columns">
        <label for="pb_form_object_provenience_de">Herkunft / Provenienz</label>
        <textarea
          class="u-full-width"
          name="date"
          id="pb_form_object_provenience_de"
        />
      </div>
      <div class="six columns">
        <label for="pb_form_object_provenience_fr">französische Übersetzung</label>
        <textarea
          class="u-full-width"
          name="date"
          id="pb_form_object_provenience_fr"
          rows="5"
        />
      </div>
    </div>

    <hr />

    <div class="row">
      <div class="four columns">
        <label for="pb_form_object_height">Höhe in cm</label>
        <input
          class="u-full-width"
          type="number"
          name="height"
          id="pb_form_object_height"
        />
      </div>
      <div class="four columns">
        <label for="pb_form_object_height">Breite in cm</label>
        <input
          class="u-full-width"
          type="number"
          name="width"
          id="pb_form_object_width"
        />
      </div>
      <div class="four columns">
        <label for="pb_form_object_height">Tiefe in cm</label>
        <input
          class="u-full-width"
          type="number"
          name="depth"
          id="pb_form_object_depth"
        />
      </div>
    </div>

    <div class="row">
      <div class="four columns">
        <label for="pb_form_object_height">Durchmesser in cm</label>
        <input
          class="u-full-width"
          type="number"
          name="height"
          id="pb_form_object_height"
        />
      </div>
      <div class="four columns">
        <label for="pb_form_object_height">Gewicht in kg</label>
        <input
          class="u-full-width"
          type="number"
          name="width"
          id="pb_form_object_width"
        />
      </div>
    </div>

    <hr />

    <label for="pb_form_object_embeds">
      <br />
      Einbettung
    </label>
    <div class="row">
      <div class="six columns">
        <pb-embeds-select />
      </div>
      <div class="six columns">
        {tags['pb-embeds-select'].french_value()}
      </div>
    </div>
   
    <div class="row">
      <div class="six columns">
        <label for="pb_form_object_markings_de">
          Markierungen<br />
          (Stempel, Etikett, Aufschrift)
        </label>
        <input
          class="u-full-width"
          type="text"
          name="markings_de"
          id="pb_form_object_markings_de"
        />
      </div>
      <div class="six columns">
        <label for="pb_form_object_markings_fr">
          <br />
          französische Übersetzung
        </label>
        <input
          class="u-full-width"
          type="text"
          name="markings_fr"
          id="pb_form_object_markings_fr"
        />
      </div>
    </div>

    <div class="row">
      <div class="six columns">
        <label for="pb_form_object_material_de">
          Material und Technik
        </label>
        <input
          class="u-full-width"
          type="text"
          name="material_de"
          id="pb_form_object_material_de"
        />
      </div>
      <div class="six columns">
        <label for="pb_form_object_material_fr">
          französische Übersetzung
        </label>
        <input
          class="u-full-width"
          type="text"
          name="material_fr"
          id="pb_form_object_material_fr"
        />
      </div>
    </div>

    <div class="row">
      <div class="six columns">
        <label for="pb_form_object_condition_de">Zustand</label>
        <input
          class="u-full-width"
          type="text"
          name="condition_de"
          id="pb_form_object_condition_de"
        />
      </div>
      <div class="six columns">
        <label for="pb_form_object_condition_fr">
          französische Übersetzung
        </label>
        <input
          class="u-full-width"
          type="text"
          name="condition_fr"
          id="pb_form_object_condition_fr"
        />
      </div>
    </div>

    <div class="row">
      <div class="six columns">
        <label for="pb_form_object_comment_de">Kommentar</label>
        <textarea
          class="u-full-width"
          name="comment_de"
          id="pb_form_object_comment_de"
        />
      </div>
      <div class="six columns">
        <label for="pb_form_object_comment_fr">französische Übersetzung</label>
        <textarea
          class="u-full-width"
          name="comment_fr"
          id="pb_form_object_comment_fr"
        />
      </div>
    </div>

    <hr />

    <div class="row">
      <div class="twelve columns">
        <label for="pb_form_object_description_de">Beschreibung</label>
        <textarea
          class="u-full-width"
          name="description_de"
          id="pb_form_object_description_de"
        />
      </div>
    </div>

    <div class="row">
      <div class="twelve columns">
        <label for="pb_form_object_description_fr">
          Beschreibung (französisch)
        </label>
        <textarea
          class="u-full-width"
          name="description_fr"
          id="pb_form_object_description_fr"
        />
      </div>
    </div>

    <hr />

    <div class="row">
      <div class="twelwe columns">
        <div id="pb-dropzone" class="dropzone">
          <div class="dz-message">hier klicken oder Bilder hineinziehen</div>
        </div>
      </div>
    </div>

    <hr />

    <div class="u-text-right">
      <input type="submit" class="button-primary" value="Speichern" />
      <input type="reset" class="button" value="Abbrechen" />
    </div>

  </form>

  <script type="text/coffee">
    self = this
    window.x = self

    self.selection_changed = -> self.update()

    self.on 'mount', ->
      self.dropzone = new Dropzone($(self.root).find('.dropzone')[0],
        url: "/file/post"
      )

      files = [
        {size: 224758, name: '005.jpg'},
        {size: 1051924, name: '006.jpg'},
        {size: 503655, name: '007.jpg'}
      ]

      for file in files
        self.dropzone.emit "addedfile", file
        self.dropzone.createThumbnailFromUrl(
          file, "/sample-data/images/#{file.name}"
        )
        self.dropzone.emit "complete", file
  </script>

</pb-object-editor>