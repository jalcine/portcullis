Feature: Classic Authentication
  @backlog
  Scenario: Successful sign-in
    When I go to the sign-in page
    And I have a pre-existing user account
    And I enter my e-mail address and password
    And I click the "Sign In" button
    Then I am signed in

  @backlog
  Scenario: Successful sign-up
    When I go to the sign-up page
    And I enter my e-mail address and password
    And I enter my password confirmation
    And I enter my name
    And I click the "Sign Up" button
    Then I am signed up
