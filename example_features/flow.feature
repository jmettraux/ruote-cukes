
Feature: running the flow

  My flow should deliver workitems to the first participant in the flow

  Scenario: from a to b
    Given I have a ruote engine
    And the initial fields are "customer":"Alain"
    And the catchall participant is registered
    And I launch the flow at example_flows/a_to_b.rb
    When I get the first workitem of participant alpha
    Then I should have a workitem
    And the process should be alive
    And the process should have no errors

