require 'rails_helper'

Rspec.describe 'Admin Dashboard' do
  describe 'As an Admin' do
    it 'I see a header indicating that I am on the admin dashboard' do
      visit admin_path

      expect(page).to have_content('Admin Dashboard')
    end

    it 'I see names of top 5 customers with largest number of successful transactions' do
      #create instance of 6 customers
      custmr_1 = Customer.create!(first_name: "Alessandra", last_name: "Ward")
      custmr_2 = Customer.create!(first_name: "Tremayne", last_name: "Zieme")
      custmr_3 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
      custmr_4 = Customer.create!(first_name: "Demarcus", last_name: "King")
      custmr_5 = Customer.create!(first_name: "Dejon", last_name: "Fadel")
      custmr_6 = Customer.create!(first_name: "Dell", last_name: "Ernser")
      
      visit admin_path

      expect(page).to have_content('Top Customers')
      expect(page).to have_content()
    end
  end
end
