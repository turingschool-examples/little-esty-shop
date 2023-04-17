require 'rails_helper'

RSpec.describe 'Admin Invoices Show Page', type: :feature do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Will', last_name: 'Rogers')
    @customer_2 = Customer.create!(first_name: 'Carl', last_name: 'Weathers')
    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25')
    @invoice_2 = @customer_2.invoices.create!(status: 0, created_at: '2012-03-24')
  end
  
  describe 'As an Admin, When I visit the admin invoice show page' do
    describe 'I see information related to that invoice including:' do
      it 'Invoice id, status, created_at date, and customer name' do 
        visit admin_invoice_path(@invoice_1)

        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content("Status: completed")
        expect(page).to have_content("Created At: Sunday, March 25, 2012")
        expect(page).to have_content("Customer Name: Will Rogers")
        
        visit admin_invoice_path(@invoice_2)
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content("Status: in_progress")
        expect(page).to have_content("Created At: Saturday, March 24, 2012")
        expect(page).to have_content("Customer Name: Carl Weathers")
      end
    end
  end
end