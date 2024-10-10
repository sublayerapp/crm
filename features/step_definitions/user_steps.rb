# features/step_definitions/user_steps.rb

Given('I am on the home page') do
  visit root_path
end

When('I click {string}') do |link|
  click_link link
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I click the {string} button') do |button|
  click_button button
end

Then('I should see {string}') do |text|
  expect(page).to have_content text
end

Given('a user exists with email {string} and password {string}') do |email, password|
  User.create!(email: email, password: password, password_confirmation: password)
end

Given('I am logged in as {string}') do |email|
  steps %(
    Given a user exists with email "#{email}" and password "password"
    And I am on the home page
    When I click "Sign In"
    And I fill in "Email" with "#{email}"
    And I fill in "Password" with "password"
    And I click the "Log in" button
    Then I should see "Signed in successfully."
  )
end

