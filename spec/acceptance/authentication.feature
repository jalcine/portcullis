Feature: Signing up with Facebook
  Background:
    When I go to the sign-up page

  Scenario: works
    When I sign up with Facebook 
    Then A new user should be created from data from facebook

  Scenario: fails
    When I sign up with Facebook
    And the provider is bound to fail
    Then I should see an error
