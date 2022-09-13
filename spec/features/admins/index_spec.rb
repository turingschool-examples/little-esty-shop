require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  describe "As an admin" do
    describe "I visit the admin dashboard" do
      it "I see a header indicating that I am on the admin dashboard" do
        visit admins_path

        expect(page).to have_content("Admin Dashboard")
      end

      it "will show a link to the admin merchants index (/admin/merchants)and invoices index (/admin/invoices)" do
        visit admins_path
        expect(page).to have_link("Merchants Index")
        expect(page).to have_link("Invoice Index")
      end

      it "will have working links to the merchants" do
        visit admins_path
        click_on "Merchants Index"
        expect(current_path).to be("/admins/merchants")
      end

      it "will have working links to the invoice indexs" do
        visit admins_path
        click_on "Invoice Index"
        expect(current_path).to be("/admins/invoices")
      end
    end
  end
end