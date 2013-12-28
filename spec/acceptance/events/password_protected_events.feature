Feature: Password Protected Events
  Background:
    Given a host is signed in
    And there is a password-protected event I don't own
    And I go to view the event

  Scenario: Prevents access to password-protected events for foreign users
    Then I should be required to enter a password to view the event

  Scenario: Permits access to password-protected events for those with the password
    When I enter the password for the password-protected event
    Then I should be redirected to the event
    Then I should be able to view the password-protected event
