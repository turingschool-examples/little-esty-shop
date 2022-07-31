require 'rails_helper'
RSpec.describe "admin dashboard" do 
   it "has a header indicating the user is on the admin dashboard" do 
      
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
   end

   it "has a link to the admin merchants index and admin invoices index" do 
      
      visit "/admin"

      expect(page).to have_link("Admin Merchants Index")
      expect(page).to have_link("Admin Invoices Index")
   end
end

# Admin Dashboard Links

# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a link to the admin merchants index (/admin/merchants)
# And I see a link to the admin invoices index (/admin/invoices)