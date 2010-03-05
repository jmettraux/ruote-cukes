
Feature: When I launch

  of course, launch may be a Given or a When

  Scenario: from alpha to bravo
    Given I have a ruote engine
    And the catchall participant is registered
    When I launch the flow at flows/a.rb
    Then the process should reach alpha
    When I reply
    Then the process should be over

