require 'rails_helper'

RSpec.describe 'Admin Dashboard Page', type: :feature do
    let!(:joey) { Customer.create!(first_name: "Joey", last_name: "Ondricka")}

    let!(:invoice1) { joey.invoices.create!(status: 2) }
    let!(:invoice2) { joey.invoices.create!(status: 1) }
    let!(:invoice3) { joey.invoices.create!(status: 0) }
    let!(:invoice4) { joey.invoices.create!(status: 2) }
    # let!(:item1) { invoice1.items.create!(status: 2) }
    # let!(:item2) { invoice4.items.create!(status: 2) }
    describe 'Header' do
        it 'indicates admin is on the dashboard' do
            visit admin_index_path
            expect(page).to have_content("Admin Dashboard")
        end
    end

    describe 'Dashboard Links' do 
        it 'links to the merchants index' do
            visit admin_index_path
            expect(page).to have_link("Admin Merchants Index")
            click_on("Admin Merchants Index")
            expect(current_path).to be("/admin/merchants")
        end

        it 'links to the admin invoices index' do
            visit admin_index_path
            expect(page).to have_link("Admin Invoices Index")
            click_on("Admin Invoices Index")
            expect(current_path).to be("/admin/invoices")
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

    end
end