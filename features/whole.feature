
Feature: ruote-cukes features

  showing a rather complete example

  Scenario: alpha to bravo
    Given I have a ruote engine
    And the catchall participant is registered
    When I launch the flow
      """
      Ruote.process_definition do
        sequence do
          alpha
          participant :ref => '${f:next}'
        end
      end
      """
    Then the process should reach alpha
    When I get the first workitem of participant alpha
    And I update the workitem with
      | next | charly |
    And I reply with the workitem
    Then the process should reach charly

