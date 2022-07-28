require 'rails_helper'

RSpec.describe 'admin invoice show page' do 

    it "shows the item on an admin invoice show page" do
    
        customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
        customer_2 = Customer.create!(first_name: "Kyle", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
    

        invoice_1 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id )
        invoice_2 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id )
        invoice_3 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id )
        invoice_4 = Invoice.create!(status: :completed, created_at: "2012-03-25 09:54:09 UTC", updated_at: Time.now, customer_id: customer_5.id )
    
        visit "admin/invoices"
        
        click_on("#{invoice_1.id}")
        expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")

        expect(page).to have_content("#{invoice_1.id}")
        expect(page).to have_content("#{invoice_1.status}")
        expect(page).to have_content("Date: Thursday, July 28, 2022")
        expect(page).to have_content("Customer: Craig Randalson")
    end
end