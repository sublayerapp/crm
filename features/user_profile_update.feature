Feature: User Profile Update

  As a user, I want to update my profile information, so that my account details are accurate.

  Background:
    Given a user exists with email "testuser@example.com" and password "password"
    And I am logged in as "testuser@example.com"

  Scenario: Access profile page
    When I visit my profile page
    Then I should see my current email "testuser@example.com"

  Scenario: Update user name
    When I visit my profile page
    And I fill in "Name" with "Updated User"
    And I click the "Update" button
    Then I should see "Your account has been updated successfully."
    And my profile name should be "Updated User"

  Scenario: Update user email
    When I visit my profile page
    And I fill in "Email" with "updated@example.com"
    And I fill in "Current password" with "password"
    And I click the "Update" button
    Then I should see "You updated your account successfully, but we need to verify your new email address. Please check your email and follow the confirmation link to confirm your new email address."

  Scenario: Update user password
    When I visit my profile page
    And I fill in "Password" with "newpassword"
    And I fill in "Password confirmation" with "newpassword"
    And I fill in "Current password" with "password"
    And I click the "Update" button
    Then I should see "Your account has been updated successfully."

  Scenario: Validation errors on profile update
    When I visit my profile page
    And I fill in "Email" with "invalidemail"
    And I click the "Update" button
    Then I should see "is invalid"