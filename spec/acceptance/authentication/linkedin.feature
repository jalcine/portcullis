Feature: Authentication with LinkedIn

  @wip
  Scenario: works like a charm
    When I go to the sign-up page
    When I sign up with LinkedIn
    Then I am signed in
    Then I can sign in using LinkedIn

  @wip
  Scenario: gives me a profile
    When I go to the sign-up page
    When I sign up with LinkedIn
    Then I am signed in
    Then I should have a profile

  @wip
  Scenario: signs me in if I try to sign up
    When I go to the sign-up page
    And I have a pre-existing account with linkedin
    And I sign up with linkedin
    Then I am signed in
    Then I should have a profile
