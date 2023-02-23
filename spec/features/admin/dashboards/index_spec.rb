require 'rails_helper'

describe 'admin index page' do
  # before(:each) do
    describe 'user story 19' do
      it 'displays a header indicating that visitor is on the admin dashboard' do
        visit admin_path

        expect(page).to have_content("Admin Dashboard")
      end
    end

    describe 'user story 20' do 
      it 'has links to the admin merchants index and the admin invoices index' do 
  
        visit admin_path 

        expect(page).to have_link("Admin Merchants")
        expect(page).to have_link("Admin Invoices")
      end
    end
  
  # end
end  