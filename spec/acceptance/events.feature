Feature: Events
  Background:
    Given there's a user signed in

  Scenario: Saves a new whole event
    When I go to the new events page
    And I set the event's title with "Captain Underpants: The Reunion"
    And I set the event's description to some placeholder text
    And I add 30 free tickets to the event named "Early Bird"
    And I populate the time range for the event
    And I confirm creation of the event
    Then it should create a new event
    Then it should show the new event page
    Then I should have 30 tickets
    Then the page should have the text "Captain Underpants: The Reunion"
