Feature: Protected Events
  Background:
    Given a host is signed in

  @wip
  Scenario: Prevents access to password-protected events for foreign users
    When there is a password-protected event I don't own
    And I go to view the event
    Then I should be required to enter a password to view the event

  @backlog
  Scenario: Permits access to password-protected events for those with key
    When there is a password-protected event I don't own
    And I go to view the event
    And I enter the key for password-protected event
    Then I should be redirected
    Then I should be able to view the password-protected event
