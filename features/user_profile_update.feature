Feature: User Profile Update

  As a user, I want to update my profile information, so that my account details are accurate.

  Scenario: Accessing the Profile Page
    Given I am logged in as "testuser@example.com"
    When I visit my profile page
    Then I should see my current email address

  Scenario: Updating User Name
    Given I am logged in as "testuser@example.com"
    When I visit my profile page
    And I fill in "Name" with "Updated User Name"
    And I click the "Update Profile" button
    Then I should see "Your account has been updated successfully."
    And my profile name should be "Updated User Name"

  Scenario: Updating User Email
    Given I am logged in as "testuser@example.com"
    When I visit my profile page
    And I fill in "Email" with "updated@example.com"
    And I click the "Update Profile" button
    Then I should see "You updated your account successfully, but we need to verify your new email address."

  Scenario: Updating User Password
    Given I am logged in as "testuser@example.com"
    When I visit my profile page
    And I fill in "Current password" with "password"
    And I fill in "Password" with "newpassword"
    And I fill in "Password confirmation" with "newpassword"
    And I click the "Update Profile" button
    Then I should see "Your account has been updated successfully."

  Scenario: Validation Errors
    Given I am logged in as "testuser@example.com"
    When I visit my profile page
    And I fill in "Email" with "invalidemail"
    And I click the "Update Profile" button
    Then I should see "Email is invalid"