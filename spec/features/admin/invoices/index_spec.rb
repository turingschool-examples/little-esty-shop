require 'rails_helper'

RSpec.describe "Admin Invoice Index Page" do
  describe "As an admin" do
    describe "I visit the admin Invoices index (/admin/invoices)" do
      before :each do
        @invoices_1 = create_list(:invoice, 10)
      end
      
      it "I see a list of all Invoice ids in the system" do
        visit admin_invoices_path

        @invoices_1.each do |invoice|
          within("#invoice-#{invoice.id}") do
            expect(page).to have_content("Invoice ##{invoice.id}")
          end
        end
      end

      it "Each id links to the admin invoice show page" do 

        @invoices_1.each do |invoice|
          visit admin_invoices_path
          within("#invoice-#{invoice.id}") do
            click_link"Invoice ##{invoice.id}"
          end
          expect(current_path).to eq admin_invoice_path(invoice)
        end

      end
    end
  end
end
