require "rails_helper"

RSpec.describe "Admin#index" do 
    it 'Displays a header that user is on Admin' do 
        visit "/admin"
        expect(page).to have_content("Admin")
    end
#Admin Dashboard Links
# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a link to the admin merchants index (/admin/merchants)
# And I see a link to the admin invoices index (/admin/invoices)
    it 'It has links to Admin/merchants' do 
        visit "/admin"
        expect(page).to have_link("Merchants")
    end
    
     it 'It has links to Admin invoices' do 
        visit "/admin"
        expect(page).to have_link("Invoices")
        
    end

#Admin Dashboard Statistics - Top Customers
# As an admin,
# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have conducted

end