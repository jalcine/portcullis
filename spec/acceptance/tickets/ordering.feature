Feature: Ordering tickets
  Background:
    Given a attendee is signed in
    And I have a pre-existing event
    And the pre-existing event is currently active
    And all of the tickets for the event are available
    And I go to view the event

  @js
  @broken
  Scenario: ordering one ticket
    When I pick the first ticket to order
    And I choose to order 4 tickets on the event page
    And I click the "Order" link
    Then I see a confirmation to order the tickets
    And I see the price of the final transaction

  @js
  @broken
  Scenario: ordering multiple ticket
    When I pick multiple tickets to order
    And I choose to order 2 tickets on the event page
    And I click the "Order" link
    Then I should see a confirmation to order the tickets
    And I should see the price of the final transaction
