Feature: Classic Authentication
  @wip
  Scenario: Successful sign-in
    When I go to the sign-in page
    And I enter my e-mail address and password
    And I click the "Sign In" button
    Then I am signed in

  @backlog
  Scenario: Successful sign-up
    When I go to the sign-up page
    And I enter my e-mail address and password
    And I enter my password confirmation
    And I click the "Sign Up" button
    Then I am signed in
