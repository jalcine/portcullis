Feature: Creating new events
  Background:
    Given there's a user signed in

  Scenario: Setting the start time & date
    When I go to the new events page
    And set a start time & date for the event
    Then it updates the internal start timestamp

  Scenario: Setting the end time & date
    When I go to the new events page
    And set a end time & date for the event
    Then it updates the internal end timestamp

  Scenario: Saves a new event
    When I go to the new events page
    And fill in the event's title with "Captain Underpants Reunion"
    And populate the event's time range
    And fill in the event's description with some placeholder text
    And click the "Create Event" button
    Then it should create a new event
    Then it should show the new event page
    Then the page should have the text "Captain Underpants Reunion"
