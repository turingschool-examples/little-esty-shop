require 'rails_helper'

RSpec.describe 'Admin Invoices Index' do
    before :each do 
      visit "/admin/invoices"
    end

    it "has a header" do 
      expect(page).to have_content("Admin Invoices Index")
    end

    it "has invoice ID links" do 
      expect(page).to have_link(invoice_1.id)
      expect(page).to have_link(invoice_2.id)
      expect(page).to have_link(invoice_3.id)
      expect(page).to have_link(invoice_4.id)
      expect(page).to have_link(invoice_5.id)
      click_link(invoice_2.id)
      expect path to eq("admin/invoice/#{invoice_5}")
    end


  end
end 
Then I see a list of all Invoice ids in the system
Each id links to the admin invoice show page
