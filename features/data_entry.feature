Feature: data entry

  @javascript
  Scenario: Create a main entry
    When I am on "the main page"
    And I follow "Neu"
    Then I should see "erstellen"
    When I fill the following values
      | field                 | value                  |
      | Objektbezeichnung     | Kaiserliche Sitzgruppe |
      | Fortlaufende Nummer   | 001                    |
      | Herkunft / Provenienz | some value 123         |
      | Historische Nachweise | bla bla                |
      | Literatur             | Bible                  |
      | Beschreibung          | some stuff             |
      | Würdigung             | thank you!             |
    And I press "Speichern"
    Then I should see "Haupteintrag wurde angelegt"
    Then I should see "Objekte"
    And I should see "Kaiserliche Sitzgruppe"

  @javascript
  Scenario: Update a main entry

  @javascript
  Scenario: Remove a main entry

  @javascript
  Scenario: add sub entries to a main entry