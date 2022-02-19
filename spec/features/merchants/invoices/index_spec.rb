require 'rails_helper'

RSpec.describe 'Merchant invoice index page', type: :feature do
  before do
    @merchant = create(:merchant)
  end

  xit 'displays invoice index info' do
    item = create(:item, merchant: @merchant)
    ii1 = create(:invoice_item, item: item)
    ii1 = create(:invoice_item, item: item)
    ii1 = create(:invoice_item, item: item)

    visit "/merchants/#{@merchant.id}/invoices"

    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    expect(page).to have_content(ii1.invoice.id)
    expect(page).to have_content(ii2.invoice.id)
    expect(page).to have_content(ii3.invoice.id)
  end
end 
