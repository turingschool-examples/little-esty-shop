require 'rails_helper'

RSpec.describe "Admin Dashboard" do
    before :each do
      test_data
   end

   it 'has a header indicating that it is the admin dashboard' do
      visit '/admin'

      expect(page).to have_content("Admin Dashboard")
   end

   it 'has a link to the admin merchants index' do
      visit '/admin'

      expect(page).to have_link("Merchants")
   end

    it 'has a link to the admin invoices index' do
      visit '/admin'

      expect(page).to have_link("Invoices")
   end

   it 'lists the top 5 customers by successful transactions' do
      visit '/admin'

      expect(page).to have_content("Top 5 Customers")
      expect(page).to have_content("Customer 1")
      expect(page).to have_content("Customer 2")
      expect(page).to have_content("Customer 3")
      expect(page).to have_content("Customer 4")
      expect(page).to have_content("Customer 5")
   end
  end