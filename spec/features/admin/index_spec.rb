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
            visit("/admin")
            expect(page).to have_content("Admin Dashboard")
        end
    end

    describe 'Incomplete Invoices' do
        it 'has a section for incomplete invoices' do
            visit("/admin")
            save_and_open_page
            within("#incomplete_invoices") do
                expect(page).to have_content("Invoice ##{invoice1.id}")
                expect(page).to have_content("Invoice ##{invoice4.id}")
                expect(page).to_not have_content("Invoice ##{invoice2.id}")
            end
        end
        
    end
end