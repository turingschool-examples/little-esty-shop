require 'rails_helper'
RSpec.describe "Admin Invoices Show", type: :feature do 
  let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }

  let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice4) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice5) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 

  describe "As an admin" do
    context "When I visit the admin invoice show page" do
      before do
        visit admin_invoice_path(invoice1)
      end

      it "I see the invoice ID" do
        expect(page).to have_content("#{invoice1.id}")
        expect(page).to_not have_content("#{invoice2.id}")
        expect(page).to_not have_content("#{invoice5.id}")
      end

      it "I see the invoice status" do
        expect(page).to have_content("in progress")
        expect(page).to have_content("#{invoice1.status}")
      end

      it "I see the invoice created_at date in the format 'Monday, July 18, 2019'" do
        expect(page).to have_content("#{invoice1.created_at.strftime("%A, %B %d, %Y")}")
      end

      it "I see customer first and last name'" do
        expect(page).to have_content("#{"Dis Gai"}")
        expect(page).to have_content("#{invoice1.customer.first_name}")
        expect(page).to have_content("#{invoice1.customer.last_name}")
      end
    end
  end
end