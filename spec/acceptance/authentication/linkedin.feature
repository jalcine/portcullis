Feature: Authentication with LinkedIn
  Background:
    When I go to the sign-up page

  @wip
  Scenario: works like a charm
    When I sign up with LinkedIn
    Then A new user should be created from data from linkedin
