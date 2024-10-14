Feature: Create New Contact

  As a user, I want to create a new contact, so that I can store information about the individuals I interact with

  Background:
    Given I am logged in as "user@example.com"

  Scenario: Accessing New Contact Form
    Given I am on the contacts page
    Then I should see a "New Contact" button

  Scenario: Filling and Submitting Contact Form
    Given I am on the new contact page
    When I fill in "Name" with "John Doe"
    And I fill in "Email" with "john.doe@example.com"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Address" with "123 Main Street"
    And I click the "Create Contact" button
    Then I should be redirected to the contact's detail page
    And I should see "Contact created successfully."

  Scenario: Form Validation
    Given I am on the new contact page
    When I fill in "Email" with "invalid-email"
    And I click the "Create Contact" button
    Then I should see "Please enter a valid email address."