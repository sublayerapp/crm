Given('I am on the contacts page') do
  visit contacts_path # Replace with actual path if different
end

Then('I should see a {string} button') do |button_text|
  expect(page).to have_link button_text
end

When('I click the {string} button') do |button_text|
  click_link button_text
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

Then('I should be redirected to the contact\'s detail page') do
  expect(current_path).to match(%r{/contacts/\d+})
end

Then('I should see {string}') do |message|
  expect(page).to have_content message
end