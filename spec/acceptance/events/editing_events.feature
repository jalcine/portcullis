Feature: Editing Events
  Background:
    Given a host is signed in

  @backlog
  Scenario: Edits an event
    When I have a pre-existing event
    And I go to edit my pre-existing event
    Then it should have its fields pre-populated
