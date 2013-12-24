Feature: Events
  Background:
    Given a host is signed in

  Scenario: Prevents access to password-protected events for foreign users
    When There is a password-protected event I don't own
    And I go to view the password-protected event
    Then I should be required to enter a password to view the event

  Scenario: Permits access to password-protected events for those with key
    When There is a password-protected event I don't own
    And I go to view the password-protected event
    And I enter the key for password-protected event
    Then I should be redirected
    Then I should be able to view the content of the password-protected event.
