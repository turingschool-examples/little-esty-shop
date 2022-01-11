require 'rails_helper'

RSpec.describe 'Merchant Invoices Index page' do
  it 'shows all of the invoices that include at least one of the merchants items with a link to that invoice' do
    invoice_item1 = FactoryBot.create(:invoice_item)
    invoice_item2 = FactoryBot.create(:invoice_item)
    invoice_item3 = FactoryBot.create(:invoice_item)
    item = Item.find(invoice_item1.item_id)
    visit "/merchants/#{item.merchant_id}/invoices"
    # save_and_open_page
    expect(page).to have_content(invoice_item1.invoice_id)
    click_on(invoice_item1.invoice_id)
    expect(current_path).to eq("/merchants/#{item.merchant_id}/invoices/#{invoice_item1.invoice_id}")
  end
end
