require 'rails_helper'

RSpec.describe "Admin Dashboard" do 
  describe "visit admin dashboard" do 
    it "can see a header indicating admin dashboard" do 
      visit "/admin"

      expect(page).to have_content("admin dashboard")
    end
  end

  describe "admin dashboard links" do 
    it "can see links to admin merchants index" do 
      visit "/admin"
      click_on 'merchants'
      expect(current_path).to eq(admin_merchants_path)
    end
  end

  describe "admin dashboard links" do 
    it "can see links to admin invoices index" do 
      visit "/admin"
      click_on 'invoices'
      expect(current_path).to eq(admin_invoices_path)
    end
  end

  describe "dashboard top customers" do 
    it "can see the names of top 5 customers" do 
      visit "/admin"
    end
  end

end


# Admin Dashboard Statistics - Top Customers

# As an admin,
# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant