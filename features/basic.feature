
Feature: basic

  a basic feature example

  Scenario: from a to b
    Given I have a ruote engine
    And the catchall participant is registered
    And I launch the flow at flows/a_to_b.rb
    When I get the first workitem of participant alpha
    Then I should have a workitem
    And the process should be alive
    And the process should have no errors

