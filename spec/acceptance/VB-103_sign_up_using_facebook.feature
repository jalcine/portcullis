Feature: Signing up with Facebook
  Background:
    When I go to the sign-up page
    And I sign in with facebook
    
  Scenario: signing up works
    When Provider facebook gets the user
    Then A new user should be created from data from facebook

  Scenario: signing up fails
    When Provider facebook fails to get the user
    Then I should see an error
