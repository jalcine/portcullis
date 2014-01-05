Feature: Creating Tickets
  Background:
    Given a host is signed in
    And I go to create an event 

  @wip
  Scenario: Creating free tickets
    When I add 3 free tickets to the event named "Patrick Loves Me"
    Then the event has a ticket named "Patrick Loves Me"

  @wip
  Scenario: Creating priced tickets
    When I add 3 priced tickets to the event named "Early Worm's Death"
    Then the event has a priced ticket named "Early Worm's Death"

  @wip
  Scenario: Creating donational tickets
    When I add 3 donational tickets to the event named "Feed Me, Seymore"
    Then the event has a donational ticket named "Feed Me, Seymore"
