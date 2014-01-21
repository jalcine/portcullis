Feature: Authentication with Facebook
  Given: I go to the sign-up page

  Scenario: works like a charm
    When I sign up with Facebook 
    Then I can sign in using Facebook

  Scenario: gives me a profile
    When I sign up with Facebook 
    Then I should have a profile

  Scenario: signs me in if I try to sign up
    When I have a pre-existing account with facebook
    And I sign up with facebook
    Then I am signed in
    Then I should have a profile
