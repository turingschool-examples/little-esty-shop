require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page' do 
    before(:each) do 
        @invoice_1 = create(:invoice)
        @invoice_2 = create(:invoice)
        @invoice_3 = create(:invoice)
    end
    it 'will show all invoices' do 
        visit "/admin/invoices"
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_3.id)
    end
    it 'will have links to the show page' do 
        visit "/admin/invoices"
        expect(page).to have_link("Invoice #{@invoice_1.id}")
        click_link("Invoice #{@invoice_1.id}")
        expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    end

end

# Admin Invoices Index Page

# As an admin,
# When I visit the admin Invoices index ("/admin/invoices")
# Then I see a list of all Invoice ids in the system
# Each id links to the admin invoice show page