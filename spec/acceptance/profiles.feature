Feature: Profiles
  @broken
  @backlog
  Scenario: Creating a new profile after sign-up
    When I sign up with a new account
    Then I should have a profile
