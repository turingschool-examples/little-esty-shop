require 'rails_helper'
include ActionView::Helpers::NumberHelper
RSpec.describe 'Admin Invoices Show Page' do 
    before(:each) do 
        @invoice= create(:invoice)
        @invoice_item_1 = create(:invoice_item, invoice_id: @invoice.id)
        @invoice_item_2 = create(:invoice_item, invoice_id: @invoice.id)
    end
    it 'will have the invoice information on the page' do 
        visit(admin_invoice_url(@invoice.id))
        expect(page). to have_content(@invoice.id)
        expect(page). to have_content(@invoice.status)
        expect(page). to have_content(date_formatter(@invoice.created_at))
        expect(page). to have_content(@invoice.customer.first_name)
        expect(page). to have_content(@invoice.customer.last_name)
    end
    it 'will have invoice item information (item name, quantity, price invoice item status' do 
        visit(admin_invoice_url(@invoice.id))
        expect(page).to have_content(@invoice_item_1.item.name)
        expect(page).to have_content(@invoice_item_1.quantity)
        expect(page).to have_content(@invoice_item_1.unit_price)
        expect(page).to have_content(@invoice_item_1.status)
        expect(page).to have_content(@invoice_item_2.item.name)
        expect(page).to have_content(@invoice_item_2.quantity)
        expect(page).to have_content(@invoice_item_2.unit_price)
        expect(page).to have_content(@invoice_item_2.status)
    end
    it 'will show the total revenue generated from the invoice' do 
        visit(admin_invoice_url(@invoice.id))
        expect(page).to have_content(number_to_currency(@invoice.total_revenue))
    end
end



# As a merchant
# When I visit my merchant invoice show page
# I see that each invoice item status is a select field
# And I see that the invoice item's current status is selected
# When I click this select field,
# Then I can select a new status for the Item,
# And next to the select field I see a button to "Update Item Status"
# When I click this button
# I am taken back to the merchant invoice show page
# And I see that my Item's status has now been updated