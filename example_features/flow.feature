
Feature: running the flow

  In order to blah

  Scenario: from a to b
    Given I have a ruote engine
    And the initial fields are "customer":"Alain"
    And the catchall participant is registered
    And I launch the flow at example_features/flows/a_to_b.rb
    When I get the first workitem of participant alpha
    Then I should have a workitem

