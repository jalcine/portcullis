Feature: Search
  Background:
    Given I am on the home page

  @backlog
  Scenario: Find events by title
    Given some sample events:
      | name |
      | Stark Expo 2010  |
      | Picnic for Apple |
    When I search for "Stark Expo 2010"
    And I should see the event called "Stark Expo 2010" in the event list
    But I should not see the event called "Picnic for Apple" in the event list

  @backlog
  Scenario: No events found
    When I search for "Armor Wars"
    And I should see a message indicating no events were found
