Feature: Authentication with Facebook
  Background:
    When I go to the sign-up page

  @wip
  Scenario: works like a charm
    When I sign up with Facebook 
    Then A new user should be created from data from facebook
