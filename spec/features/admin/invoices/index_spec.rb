require 'rails_helper'
RSpec.describe "Admin Invoices Index", type: :feature do 
  let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }

  let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice4) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice5) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 

  describe "As an admin" do
    context "When I visit the admin invoices index (/admin/invoices)" do
      before do
        visit admin_invoices_path
      end

      it "Sees a list of all iInvoice ids in the system" do
        expect(page).to have_content("#{invoice1.id}")

        expect(page).to have_content("#{invoice2.id}")

        expect(page).to have_content("#{invoice3.id}")

        expect(page).to have_content("#{invoice4.id}")

        expect(page).to have_content("#{invoice5.id}")
      end

      it "Each id links to the admin invoice show page" do
        within "#invoice-#{invoice1.id}" do
          click_link "#{invoice1.id}"

          expect(page).to have_current_path(admin_invoice_path(invoice1.id))
        end

        visit admin_invoices_path

        within "#invoice-#{invoice2.id}" do
          click_link "#{invoice2.id}"

          expect(page).to have_current_path(admin_invoice_path(invoice2.id))
        end
        
        visit admin_invoices_path

        within "#invoice-#{invoice3.id}" do
          click_link "#{invoice3.id}"

          expect(page).to have_current_path(admin_invoice_path(invoice3.id))
        end

        visit admin_invoices_path

        within "#invoice-#{invoice4.id}" do
          click_link "#{invoice4.id}"

          expect(page).to have_current_path(admin_invoice_path(invoice4.id))
        end

        visit admin_invoices_path

        within "#invoice-#{invoice5.id}" do
          click_link "#{invoice5.id}"

          expect(page).to have_current_path(admin_invoice_path(invoice5.id))
        end
      end
    end
  end
end