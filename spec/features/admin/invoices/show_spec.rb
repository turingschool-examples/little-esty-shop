require 'rails_helper'

RSpec.describe "admin/invoices#show" do
  before :each do
    test_data
    visit admin_invoice_path(@invoice_1)
  end

  describe 'As an admin, when I visit an admin invoice show page' do
    it 'has invoice ID' do

      expect(page).to have_content(@invoice_1.id)
    end

    it 'has status' do

      expect(page).to have_content(@invoice_1.status)
    end

    it 'has created at formatted' do

      expect(page).to have_content(@invoice_1.created_at_formatted)
    end

    it 'has customer first and last name' do

      expect(page).to have_content("#{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
    end

 
    describe 'I see the invoice status is a select field
      and I see that the invoices current status is selected,
      and next to the select field I see a button to "Update Invoice Status' do
        
      it 'When I click this select field, then I can select a new status for the Item
        and when I click the button I am taken back to the admin show page 
        and I see that the invoice status has been updated' do

        within "#update_invoice_status" do
          expect(@invoice_1.status).to eq("cancelled")
          save_and_open_page
          find("#status option[value='in progress']").select_option
          click_button("Update Invoice")
          
          expect(current_path).to eq(admin_invoice_path(@invoice_1))
          @invoice_1.reload
          expect(@invoice_1.status).to eq("in progress")
        end
      end
    end
  end
end