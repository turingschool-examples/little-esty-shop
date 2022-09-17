require 'rails_helper'

RSpec.describe 'admin invoice index' do

    let!(:joey) { Customer.create!(first_name: "Joey", last_name: "Ondricka")}

    let!(:invoice1) { joey.invoices.create!(status: :completed) }
    let!(:invoice2) { joey.invoices.create!(status: :in_progress) }
    let!(:invoice3) { joey.invoices.create!(status: :cancelled) }
    let!(:invoice4) { joey.invoices.create!(status: :cancelled) }
    # let!(:item1) { invoice1.items.create!(status: 2) }
    # let!(:item2) { invoice4.items.create!(status: 2) }
    
    it 'shows all invoices' do
        visit admin_invoices_path
        expect(page).to have_content(invoice1.id)
        expect(page).to have_content(invoice2.id)
        expect(page).to have_content(invoice3.id)
        expect(page).to have_content(invoice4.id)
    end
end