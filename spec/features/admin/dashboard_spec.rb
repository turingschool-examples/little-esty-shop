require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'As an admin user' do
    #  before(:each) do
    #   @app_1 = create(:application, status: 'Pending')
    #   @pet_1 = create(:pet, name: 'Bruiser')
    #   @pet_2 = create(:pet, name: 'Blanche')
    #   @pet_3 = create(:pet, name: 'Bowwow')
    # end

    it "when I visit the admin dashboard I see a header" do 

      # visit "/admin"
      visit admin_root_path

      expect(page).to have_content("Admin Dashboard")
    end
  
    it 'I see a link to the admin merchants and invoices index' do
      # visit admin_path
       visit admin_root_path

      expect(page).to have_link('Merchants')
      expect(page).to have_link('Invoices')
      
      click_link 'Merchants'

      expect(current_path).to eq(admin_merchants_path)

      # visit admin_path
       visit admin_root_path

      click_link 'Invoices'

      expect(current_path).to eq(admin_invoices_path)
    end
    # it "can see the names of top 5 customers with number of succesful transactions " do 



    #   # visit admin_path 
    #    visit admin_root_path


    #   expect(page).to 

    # end

# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant
  end 
end 
