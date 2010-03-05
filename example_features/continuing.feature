
Feature: no sleep till bravo

  till bravo

  Scenario: from alpha to bravo
    Given I have a ruote engine
    And the catchall participant is registered
    When I launch the flow at example_flows/a_to_b.rb
    Then the process should reach alpha
    When I get the first workitem of alpha
    And I reply with the workitem
    Then the process should reach bravo

