require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do 

# Admin Dashboard 
# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard

 it "has a header indicating this is the admin dashboard" do 
  
  visit '/admin'

  expect(page).to have_content('Admin Dashboard')
 end
end