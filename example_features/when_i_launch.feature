
Feature: when I launch...

  A long time ago in a galaxy far, far away

  Scenario: from alpha to bravo
    Given I have a ruote engine
    And the catchall participant is registered
    When I launch the flow at example_flows/a_to_b.rb
    Then the process should reach alpha
    And the process should reach participant alpha

