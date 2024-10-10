# features/user_authentication.feature

Feature: User Authentication

  Scenario: User signs up
    Given I am on the home page
    When I click "Sign Up"
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I click the "Sign up" button
    Then I should see "Welcome! You have signed up successfully."

  Scenario: User signs in
    Given a user exists with email "user@example.com" and password "password"
    And I am on the home page
    When I click "Sign In"
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I click the "Log in" button
    Then I should see "Signed in successfully."

  Scenario: User signs out
    Given I am logged in as "user@example.com"
    When I click "Sign Out"
    Then I should see "Signed out successfully."
