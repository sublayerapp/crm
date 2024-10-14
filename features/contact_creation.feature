Feature: Contact Creation

  As a user
  I want to create a new contact
  So that I can store information about the individuals I interact with

  Scenario: Accessing the new contact form
    Given I am on the contacts page
    Then I should see a "New Contact" button

  Scenario: Creating a new contact
    Given I am on the contacts page
    When I click the "New Contact" button
    And I fill in "Name" with "John Doe"
    And I fill in "Email" with "john.doe@example.com"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Address" with "123 Main St"
    And I click the "Create Contact" button
    Then I should be redirected to the contact's detail page
    And I should see "Contact created successfully."

  Scenario: Validation errors on missing required fields
    Given I am on the contacts page
    When I click the "New Contact" button
    And I fill in "Name" with ""
    And I click the "Create Contact" button
    Then I should see "Name can't be blank"