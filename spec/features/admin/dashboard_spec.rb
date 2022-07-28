require 'rails_helper' 

RSpec.describe 'Admin Dashboard' do 
    it 'has a header that says admin dashboard' do
        visit '/admin'

        within "#header" do
            expect(page).to have_content("Admin Dashboard")
        end
    end    

    it 'has a header with links' do
        visit '/admin'

        within "#header" do
            expect(page).to have_link("Dashboard")
            expect(page).to have_link("Merchants")
            # click_on("Merchants")
            # expect(current_path).to eq('/admin/merchants')
        end

        visit '/admin'

        within "#header" do
            expect(page).to have_link("Invoices")
            # click_on("Invoices")
            # expect(current_path).to eq('/admin/invoices')
        end
    end  
end