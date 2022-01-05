require 'rails_helper'

RSpec.describe 'merchants invoice show page' do

  it 'displays all information related to that invoice' do
    merchant1 = create(:merchant)
    invoice1 = create(:invoice)
    item1 = create(:item, merchant: merchant1)
    invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

    visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

    expect(page).to have_content("Merchant: #{merchant1.name}")
    expect(page).to have_content("#{invoice1.id}'s Information")
    expect(page).to have_content("Status: in_progress")
    expect(page).to have_content("Created On: Wednesday, January 05, 2022")
    expect(page).to have_content("Customer: Default First Name 1 Default Last Name 1")
  end
end
