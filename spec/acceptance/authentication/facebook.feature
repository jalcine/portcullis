Feature: Authentication with Facebook

  @wip
  Scenario: works like a charm
    When I go to the sign-up page
    And I sign up with Facebook 
    Then I can sign in using Facebook

  @wip
  Scenario: gives me a profile
    When I go to the sign-up page
    And I sign up with Facebook 
    Then I should have a profile
