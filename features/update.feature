
Feature: When I update the workitem with

  changing the fields (payload) of a workitem

  Scenario: alpha to bravo
    Given I have a ruote engine
    And the catchall participant is registered
    When I launch the flow at flows/a_to_b.rb
    Then the process should reach alpha
    When I get the first workitem of alpha
    And I update the workitem with "customer":"Alf"
    And I reply with the workitem
    Then the process should reach bravo
    And the workitem should include "customer":"Alf"

