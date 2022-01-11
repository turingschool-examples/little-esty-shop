require 'rails_helper'

RSpec.describe 'merchant invoice index page' do

  let!(:merchant_1) {FactoryBot.create(:merchant)}

  let!(:item_1) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_2) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_3) {FactoryBot.create(:item, merchant: merchant_1)}

  let!(:invoice_item_1) {FactoryBot.create(:invoice_item, item: item_1)}
  let!(:invoice_item_2) {FactoryBot.create(:invoice_item, item: item_2)}
  let!(:invoice_item_3) {FactoryBot.create(:invoice_item, item: item_3)}

  it 'shows merchant invoice ids that include a merchants item' do
    visit "/merchants/#{merchant_1.id}/invoices"

    expect(page).to have_content(invoice_item_1.invoice_id)
    expect(page).to have_content(invoice_item_2.invoice_id)
    expect(page).to have_content(invoice_item_3.invoice_id)
  end

  it 'Each invoice id is a link to that invoice show page' do
    visit "/merchants/#{merchant_1.id}/invoices"

    expect(page).to have_link("#{invoice_item_1.invoice_id}")

    click_link "#{invoice_item_1.invoice_id}"

    expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices/#{invoice_item_1.invoice_id}")
  end
end
