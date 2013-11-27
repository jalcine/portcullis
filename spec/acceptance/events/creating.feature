Feature: Creating new events
  Background:
    Given there's a user signed in
    And I go to the new events page

  Scenario: Setting the start time & date
    When I set a start time & date for the event
    Then it updates the internal start timestamp

  Scenario: Setting the end time & date
    When I set a end time & date for the event
    Then it updates the internal end timestamp

  Scenario: Adding tickets
    When I add a ticket named "Early Bird"
    Then I should have 1 tickets

  Scenario: Saves a new whole event
    When I fill in the event's title with "Captain Underpants Reunion"
    And I populate the event's time range
    And I fill in the event's description with some placeholder text
    And I click the "Create Event" button
    And I add a ticket named "Early Bird"
    And I set a start time & date for the event
    And I set a end time & date for the event
    Then it should create a new event
    Then it should show the new event page
    Then the page should have the text "Captain Underpants Reunion"
