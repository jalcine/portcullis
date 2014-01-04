Feature: Authentication with LinkedIn

  @wip
  Scenario: works like a charm
    When I go to the sign-up page
    When I sign up with LinkedIn
    Then I can sign in using LinkedIn

  @wip
  Scenario: gives me a profile
    When I go to the sign-up page
    When I sign up with LinkedIn
    Then I should have a profile
