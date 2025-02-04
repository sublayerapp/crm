Feature: Contact Creation

  As a user, I want to create a new contact, so that I can store information about the individuals I interact with.

  Background:
    Given I am logged in as "test@example.com"

  Scenario: Accessing the new contact form
    Given I am on the contacts page
    Then I should see a "New Contact" button

  Scenario: Creating a new contact with valid data
    Given I am on the new contact page
    When I fill in "Name" with "John Doe"
    And I fill in "Email" with "john.doe@example.com"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Address" with "123 Main St"
    And I click the "Create Contact" button
    Then I should be on the contact details page for "John Doe"
    And I should see "Contact created successfully."

  Scenario: Creating a new contact with missing name
    Given I am on the new contact page
    When I fill in "Email" with "john.doe@example.com"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Address" with "123 Main St"
    And I click the "Create Contact" button
    Then I should see "Name can't be blank"

  Scenario: Creating a new contact with missing email
    Given I am on the new contact page
    When I fill in "Name" with "John Doe"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Address" with "123 Main St"
    And I click the "Create Contact" button
    Then I should see "Email can't be blank"

  Scenario: Creating a new contact with invalid email
    Given I am on the new contact page
    When I fill in "Name" with "John Doe"
    And I fill in "Email" with "invalid-email"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Address" with "123 Main St"
    And I click the "Create Contact" button
    Then I should see "Email is invalid"
