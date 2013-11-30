Feature: Signing up with Facebook
  Background:
    When I go to the sign-up page
    
  Scenario: signing up works
    When I sign up with Facebook 
    Then A new user should be created from data from facebook

  Scenario: signing up fails
    When the provider is bound to fail
    And I sign up with Facebook
    Then I should see an error
