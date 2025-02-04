# features/step_definitions/contact_steps.rb

Given('I am on the contacts page') do
  visit contacts_path # Replace with your actual contacts path
end

Given('I am on the new contact page') do
  visit new_contact_path # Replace with your actual new contact path
end

Then('I should see a {string} button') do |button_text|
  expect(page).to have_button button_text
end

Then('I should be on the contact details page for {string}') do |contact_name|
  contact = Contact.find_by(name: contact_name) # Assuming Contact model
  expect(page).to have_current_path contact_path(contact) # Assuming contact details route
end

Then('I should see {string}') do |text|
  expect(page).to have_content text
end