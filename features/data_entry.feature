@javascript
Feature: data entry

  Scenario: Create a main entry
    When I am on "the main page"
    And I follow "Neu"
    Then I should see "erstellen"
    When I fill in the following values
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

  Scenario: Update a main entry
    Given a main entry
    When I go to "the main entries list"
    And I follow "bearbeiten" within main entry "Kaiserliche Sitzgruppe"
    Then I should see "bearbeiten"
    When I fill in the following values
      | field             | value                  |
      | Objektbezeichnung | Kayserliche Sitzgruppe |
    And I press "Speichern"
    Then I should see "Haupteintrag wurde geändert"
    Then I should be on "the main entries list"
    Then I should see "Kayserliche Sitzgruppe"

  Scenario: Remove a main entry
    Given a main entry
    When I go to "the main entries list"
    And I follow and confirm "löschen" within main entry "Kaiserliche Sitzgruppe"
    Then I should be on "the main entries list"
    And I should not see "Kaiserliche Sitzgruppe"

  Scenario: add sub entries to a main entry
    Given a main entry
    When I go to "the main entries list"
    And I follow "Unterobjekt hinzufügen" within main entry "Kaiserliche Sitzgruppe"
    Then I should see "Unterobjekt hinzufügen"
    When I fill in the following values
      | field             | value     |
      | Objektbezeichnung | 3 Spiegel |
    And I press "Speichern und zurück zur Liste"
    Then I should see "Unterobjekt wurde angelegt"
    Then I should be on "the main entries list"
    And I should see "3 Spiegel"

  Scenario: update a sub entry
    Given a main entry
    And a sub entry
    When I go to "the main entries list" 
    And I follow "bearbeiten" within sub entry "3 Spiegel"
    When I fill in the following values
      | field             | value            |
      | Objektbezeichnung | 3 kleine Spiegel |
      | Inventarnummern   | ab 01 01         |
    And I press "Speichern und zurück zur Liste"
    Then I should see "Unterobjekt wurde geändert"
    Then I should be on "the main entries list"
    And I should see "3 kleine Spiegel"
    And I should not see "3 Spiegel"
    And I should see "ab 01 01"

  Scenario: remove a sub entry
   Given a main entry
   And a sub entry
   When I go to "the main entries list"
   And I follow and confirm "löschen" within sub entry "3 Spiegel"
   Then I should be on "the main entries list"
   And I should not see "3 Spiegel"
