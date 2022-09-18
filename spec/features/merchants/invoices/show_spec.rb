require "rails_helper"


RSpec.describe "the merchant invoices show"  do
    describe 'I see all information related to that invoice' do
        it 'can display the invoice id' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")

            visit "/merchants/#{merchant1.id}/invoices/#{invoice_1.id}"
            expect(page).to have_content("Invoice: #{invoice_1.id}")
        end

        it 'can display the invoice status' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")

            visit "/merchants/#{merchant1.id}/invoices/#{invoice_1.id}"
            expect(page).to have_content("Status: #{invoice_1.status}")
        end

        it 'can display the date format for its creation date' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
            visit "/merchants/#{merchant1.id}/invoices/#{invoice_1.id}"
            save_and_open_page
            expect(page).to have_content("Created: Sunday, September 18, 2022")
        end

        it 'can display the customers first and last name' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")

            visit "/merchants/#{merchant1.id}/invoices/#{invoice_1.id}"
            expect(page).to have_content("Customer: #{customer1.first_name} #{customer1.last_name}")
        end
    end
end