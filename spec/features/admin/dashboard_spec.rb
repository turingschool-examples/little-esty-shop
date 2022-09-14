require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  describe "As an admin" do
    describe "I visit the admin dashboard" do
      it "I see a header indicating that I am on the admin dashboard" do
        visit admin_path

        expect(page).to have_content("Admin Dashboard")
      end

      it "will show a link to the admin merchants index (/admin/merchants)and invoices index (/admin/invoices)" do
        visit admin_path
        
        expect(page).to have_link("Merchant Index")
        expect(page).to have_link("Invoice Index")
      end

      it "will have working links to the merchants" do
        visit admin_path
        click_on "Merchant Index"
        expect(current_path).to eq(admin_merchants_path)
      end

      it "will have working links to the invoice indexs" do
        visit admin_path
        click_on "Invoice Index"
        expect(current_path).to eq(admin_invoices_path)
      end
    end
  end
end