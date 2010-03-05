
Feature: the fields table can hold json values

  the second column of 

  Scenario: alpha to bravo
    Given I have a ruote engine
    And the catchall participant is registered
    And the initial fields are
      | targets | ["alice","bob"] |
    When I launch the flow
      """
      Ruote.process_definition do
        concurrent_iterator :on_field => 'targets', :to_f => 'f' do
          participant :ref => '${f:f}'
        end
      end
      """
    Then the process should reach alice
    And the process should reach bob

