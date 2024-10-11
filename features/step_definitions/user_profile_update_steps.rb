Given('a user exists with email {string} and password {string}') do |email, password|
  User.create!(email: email, password: password, password_confirmation: password)
end

Given('I am logged in as {string}') do |email|
  visit new_user_session_path
  fill_in 'Email', with: email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  expect(page).to have_content('Signed in successfully.')
end

When('I visit my profile page') do
  visit edit_user_registration_path
end

Then('I should see my current email {string}') do |email|
  expect(page).to have_field('Email', with: email)
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I click the {string} button') do |button|
  click_button button
end

Then('I should see {string}') do |message|
  expect(page).to have_content(message)
end

Then('my profile name should be {string}') do |name|
  expect(User.last.name).to eq(name)
end

Then('I should see "is invalid"') do
  expect(page).to have_content('is invalid')
end