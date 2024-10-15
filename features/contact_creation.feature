Feature: Contact Creation

  As a user
  I want to create a new contact
  So that I can store information about the individuals I interact with

  Scenario: New Contact button availability
    Given I am on the contacts page
    Then I should see a "New Contact" button

  Scenario: Contact creation form
    Given I am on the contacts page
    When I click the "New Contact" button
    Then I should see a form with fields for:
      | Field | Type     |
      | ------ | -------- |
      | Name   | text     |
      | Email  | email    |
      | Phone | tel      |
      | Address | textarea |

  Scenario: Successful contact creation
    Given I am on the new contact form
    When I fill in the following fields:
      | Field | Value |
      | ------ | ----- |
      | Name   | John Doe |
      | Email  | john.doe@example.com |
      | Phone | 123-456-7890 |
      | Address | 123 Main St, Anytown, USA |
    And I click the "Create Contact" button
    Then I should be redirected to the contact's detail page
    And I should see "Contact created successfully." message

  Scenario: Validation errors
    Given I am on the new contact form
    When I click the "Create Contact" button without filling any fields
    Then I should see validation errors for required fields