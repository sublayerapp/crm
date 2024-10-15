Given('I am on the contacts page') do
  # Assuming '/contacts' is the path for contacts page
  visit '/contacts'
end

Then('I should see a {string} button') do |button_text|
  expect(page).to have_button button_text
end

When('I click the {string} button') do |button_text|
  click_button button_text
end

Then('I should see a form with fields for:') do |table|
  table.hashes.each do |row|
    expect(page).to have_field(row['Field'], type: row['Type'])
  end
end

Given('I am on the new contact form') do
  visit '/contacts/new' # Assuming '/contacts/new' is the new contact form path
end

When('I fill in the following fields:') do |table|
  table.hashes.each do |row|
    fill_in row['Field'], with: row['Value']
  end
end

Then('I should be redirected to the contact\'s detail page') do
  expect(current_path).to match(%r{/contacts/\d+}) # Assuming contact detail page path is like '/contacts/:id'
end

Then('I should see {string} message') do |message|
  expect(page).to have_content message
end

When('I click the {string} button without filling any fields') do |button_text|
  click_button button_text
end

Then('I should see validation errors for required fields') do
  # Assuming error messages are displayed with class 'error'
  expect(page).to have_css('.error')
end