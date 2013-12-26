Feature: Unlisted Events
  Background:
    Given a host is signed in

  @wip
  Scenario:
    When there is an unlisted event I don't own
    And I go to the search page
    And I search for the unlisted event
    Then I should see a list of search results
    Then I shouldn't see the unlisted event in the search result
