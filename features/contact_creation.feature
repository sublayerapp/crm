Feature: Contact Creation

  As a user, I want to create a new contact, so that I can store information about the individuals I interact with.

  Background:
    Given I am logged in as "user@example.com"

  Scenario: Access "New Contact" button
    Given I am on the contacts page
    Then I should see "New Contact" button

  Scenario: Contact creation form includes required fields
    Given I am on the contacts page
    When I click "New Contact"
    Then I should see "Name" field
    And I should see "Email" field
    And I should see "Phone" field
    And I should see "Address" field

  Scenario: Create a new contact
    Given I am on the contacts page
    When I click "New Contact"
    And I fill in "Name" with "Test Contact"
    And I fill in "Email" with "test@example.com"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Address" with "123 Main St"
    And I click the "Create Contact" button
    Then I should be on the contact details page for "Test Contact"

  Scenario: Validation errors for missing required fields
    Given I am on the contacts page
    When I click "New Contact"
    And I fill in "Name" with ""
    And I click the "Create Contact" button
    Then I should see "Name can't be blank"