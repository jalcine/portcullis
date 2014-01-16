Feature: Unlisted Events
  Background:
    Given a host is signed in

  @broken
  @backlog
  Scenario: creating unlisted events
    When I go to the new events page
    And I set the event's title with "Snow White"
    And I set the event's description to some placeholder text
    And I populate the time range for the event
    And I confirm creation of the event
    Then there should be an unlisted event named "Snow White"

  @broken
  @backlog
  Scenario: searching for unlisted events doesn't procur results
    When there is an unlisted event I don't own
    And I go to the search page
    And I search for the unlisted event
    Then I should see a list of search results
    Then I shouldn't see the unlisted event in the search result
