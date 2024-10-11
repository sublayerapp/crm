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

When('I visit my profile page') do
  visit edit_user_registration_path
end

Then('I should see my current email address') do
  expect(page).to have_content current_user.email
end

Then('my profile name should be {string}') do |name|
  expect(User.find_by(email: current_user.email).name).to eq(name)
end