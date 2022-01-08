require 'rails_helper'

RSpec.describe 'merchant invoice index page' do

  let!(merchant_1) {FactoryBot.create(:merchant)}

  let!(item_1) {FactoryBot.create(:item, merchant: merchant)}
  let!(item_2) {FactoryBot.create(:item, merchant: merchant)}
  let!(item_3) {FactoryBot.create(:item, merchant: merchant)}

  let!(invoice_item_1) {FactoryBot.create(:invoice_item, item: item_1)}
  let!(invoice_item_2) {FactoryBot.create(:invoice_item, item: item_2)}
  let!(invoice_item_3) {FactoryBot.create(:invoice_item, item: item_3)}

  it 'shows each merchant invoice id' do
    visit "/merchants/#{@merchant.id}/invoices"

    expect(page).to have_content(invoice_item_1.invoice_id)
    expect(page).to have_content(invoice_item_2.invoice_id)
    expect(page).to have_content(invoice_item_3.invoice_id)
  end
end
