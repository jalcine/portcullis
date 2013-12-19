Feature: Events
  Background:
    Given a host is signed in

  Scenario: Saves a new event
    When I go to the new events page
    And I set the event's title with "Captain Underpants: The Reunion"
    And I set the event's description to some placeholder text
    And I populate the time range for the event
    And I add 30 free tickets to the event named "Early Bird"
    And I confirm creation of the event
    Then it should create a new event
    Then it should show the new event page
    Then I should have 30 tickets
    Then the page should have the text "Captain Underpants: The Reunion"

  Scenario: Edits an event
    When I have a pre-existing event
    And I go to edit my pre-existing event
    Then it should have its fields pre-populated

  Scenario: Deletes an event
    When I have a pre-existing event
    And I go to view my pre-exisiting event
    And I click on 'Delete'
    And I'm prompted to delete the event
    And I confirm the deletion of this event
    Then the pre-existing event should be deleted
    And it should be on the home page
