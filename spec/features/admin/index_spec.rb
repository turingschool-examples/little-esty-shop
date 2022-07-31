# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard

require 'rails_helper'
RSpec.describe "admin dashboard" do 
   it "has a header indicating the user is on the admin dashboard" do 
      
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
   end
end
