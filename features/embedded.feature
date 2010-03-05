
Feature: I launch the flow

  the process definition is embedded in the feature

  Scenario: alpha to bravo
    Given I have a ruote engine
    And the initial fields are "customer":"Alain"
    And the catchall participant is registered
    And I launch the flow
      """
      Ruote.process_definition do
        sequence do
          alpha
          bravo
        end
      end
      """
    When I get the first workitem of participant alpha
    Then I should have a workitem

