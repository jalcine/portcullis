Feature: Creating Tickets
  Background:
    Given a host is signed in
    And I go to create an event 

  @broken
  Scenario: Creating free tickets
    When I add 3 free tickets to the event named "Patrick Loves Me"
    Then the event has a free ticket named "Patrick Loves Me"
