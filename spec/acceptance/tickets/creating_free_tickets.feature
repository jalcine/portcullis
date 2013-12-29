Feature: Creating Free Tickets
  Background:
    Given a host is signed in
    And I go to create an event 

  @wip
  Scenario: Creating the free ticket
    When I add 30 free tickets to the event named "Patrick Loves Me"
    And I confirm creation of the event
    Then it should have a free ticket named "Patrick Loves Me"
