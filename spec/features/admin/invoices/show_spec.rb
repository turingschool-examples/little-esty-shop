require 'rails_helper'

RSpec.describe "Admin Invoice Show Page" do
  describe "As an admin" do
    describe "I visit an admin invoice show page" do
      before :each do
        @invoice_1 = create(:invoice)
        @invoice_2 = create(:invoice)
        @invoice_3 = create(:invoice)
        @invoice_4 = create(:invoice)
      end

      it 'I see information related to that invoice including: id, status, created_at date (format "Monday, July 18, 2019") and Customer First+Last name' do
        visit admin_invoice_path(@invoice_1)

        within("#invoice-details-#{@invoice_1.id}") do
          expect(page).to have_content("Invoice ##{@invoice_1.id}")
          expect(page).to have_content("Status: #{@invoice_1.status}")
          expect(page).to have_content("Created On: #{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
          expect(page).to have_content("#{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
        end
        
        expect(page).to_not have_content("Invoice ##{@invoice_3.id}")
        expect(page).to_not have_content("#{@invoice_3.customer.first_name} #{@invoice_3.customer.last_name}")
      end

    end
  end
end

