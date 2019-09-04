@javascript
Feature: search

  Scenario: by "Objektbezeichnung"
    Given a main entry
    Given another main entry
    When I go to "the main entries list" 
    And I fill in the following values
      | field             | value      |
      | Objektbezeichnung | königliche |
    And I press "Suchen"
    Then I should see "Königliche Sitzgruppe"
    Then I should not see "Kaiserliche Sitzgruppe"
