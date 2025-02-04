# features/step_definitions/contact_creation_steps.rb

Given('I am on the contacts page') do
  visit contacts_path # Replace with your actual contacts page path
end

Then('I should see {string} button') do |button_text|
  expect(page).to have_button button_text
end

When('I click {string}') do |link_or_button_text|
  click_link_or_button link_or_button_text
end

Then('I should see {string} field') do |field_name|
  expect(page).to have_field field_name
end

Then('I should be on the contact details page for {string}') do |contact_name|
  # Assuming contact details page uses friendly IDs or similar
  contact = Contact.find_by(name: contact_name) # Replace Contact with actual model
  expect(page).to have_current_path contact_path(contact) # Replace with actual contact path helper
end

Then("I should see {string}") do |message|
  expect(page).to have_content(message)
end