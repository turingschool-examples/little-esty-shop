require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do 

 it "has a header indicating this is the admin dashboard" do 

  visit '/admin'

  expect(page).to have_content('Admin Dashboard')
 end

 it "has links to the admin merchants and invoices indexes" do 

  visit '/admin'

  expect(page).to have_link('Admin Merchants Index')
  expect(page).to have_link('Admin Invoices Index')
 end
end