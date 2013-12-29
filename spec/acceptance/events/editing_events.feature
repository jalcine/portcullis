Feature: Editing Events
  Background:
    Given a host is signed in

  @backlog
  Scenario: handling descriptions
    When I go to the new events page
    And I set the event's title with "Snow White"
    And I set the event's description to some placeholder text
    And I populate the time range for the event
    And I confirm creation of the event
    Then there shouldn't be any HTML code on the event page
