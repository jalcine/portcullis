Feature: Classic Authentication
  Background:
    When I go to the sign-up page

  @wip
  Scenario: Successful sign-in
    When I enter my e-mail address and password
    And I click on the "Sign In" button
    Then I should be signed in
