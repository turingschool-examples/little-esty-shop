require 'rails_helper'

RSpec.describe 'Admin Dashboard Page', type: :feature do
    let!(:joey) { Customer.create!(first_name: "Joey", last_name: "Ondricka")}

    let!(:invoice1) { joey.invoices.create!(status: 2, created_at: "2021-09-1 08:44:13 PST") }
    let!(:invoice2) { joey.invoices.create!(status: 1, created_at: "2022-08-2 08:44:13 PST") }
    let!(:invoice3) { joey.invoices.create!(status: 0, created_at: "2022-09-5 08:44:13 PST") }
    let!(:invoice4) { joey.invoices.create!(status: 2, created_at: "2022-09-8 08:44:13 PST") }
    
    describe 'Header' do
        it 'indicates admin is on the dashboard' do
            visit admin_index_path
            expect(page).to have_content("Admin Dashboard")
        end
    end

    describe 'Dashboard Links' do 
        it 'links to the merchants index' do
            visit admin_index_path
            expect(page).to have_link("Merchants")
            # click_on("Merchants")
            # expect(current_path).to be("/admin/merchants")
        end

        it 'links to the admin invoices index' do
            visit admin_index_path
            expect(page).to have_link("Invoices")
            # click_on("Invoices")
            # expect(current_path).to be("/admin/invoices")
        end
    end

    describe 'Incomplete Invoices' do
        it 'has a section for incomplete invoices' do
            visit admin_index_path
            within("#incomplete_invoices") do
                expect(page).to have_content("Invoice ##{invoice1.id}")
                expect(page).to have_content("Invoice ##{invoice4.id}")
                expect(page).to_not have_content("Invoice ##{invoice2.id}")

                click_on invoice1.id
                expect(current_path).to eq("/admin/invoices/#{invoice1.id}")
            end
        end

        it 'shows the invoice dates ordered by date' do
            visit admin_index_path
            within("#incomplete_invoices") do
                expect(page).to have_content("Wednesday, September 01, 2021")
                expect(page).to have_content("Thursday, September 08, 2022")
                expect("Wednesday, September 01, 2021").to appear_before("Thursday, September 08, 2022")
            end
        end
    end
end