require 'rails_helper'

RSpec.describe 'merchants invoices index' do
  it 'displays all the invoices that include at least one of the merchants items' do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)

    merchant_2 = create(:merchant)
    item_2 = create(:item, merchant_id: merchant_2.id)
    invoice_2 = create(:invoice)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id)

    visit "/merchants/#{merchant_1.id}/invoices"

    expect(page).to have_content("Merchant's Invoices")
    expect(page).to have_content("Invoice")
    expect(page).to have_content(invoice_1.id)
  end


  it 'displays a link for each invoice id that connects to merchant invoice show page' do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)

    merchant_2 = create(:merchant)
    item_2 = create(:item, merchant_id: merchant_2.id)
    invoice_2 = create(:invoice)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id)
    visit "/merchants/#{merchant_1.id}/invoices"

    click_link "#{invoice_1.id}"

    expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}")
  end
end
