
Feature: When the initial fields are

  using a cucumber table to set the initial fields of a workitem (launchitem)

  Scenario: alpha to bravo
    Given I have a ruote engine
    And the initial fields are
      | customer | Alain-san |
      | company  | super asia exchange |
    And the catchall participant is registered
    And I launch the flow at flows/a_to_b.rb
    When I get the first workitem of participant alpha
    Then the workitem should include
      | customer | Alain-san |
      | company  | super asia exchange |

