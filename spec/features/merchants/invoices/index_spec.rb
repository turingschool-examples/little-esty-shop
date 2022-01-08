require 'rails_helper'

RSpec.describe 'merchant invoice index page' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @item = FactoryBot.create(:item, merchant: @merchant)
    @item2 = FactoryBot.create(:item, merchant: @merchant)
    @item3 = FactoryBot.create(:item, merchant: @merchant)
    @invoice_item = FactoryBot.create(:invoice_item, item: @item)
    @invoice_item2 = FactoryBot.create(:invoice_item, item: @item2)
    @invoice_item3 = FactoryBot.create(:invoice_item, item: @item3)
    visit "/merchants/#{@merchant.id}/invoices"
  end

  it 'shows each merchant invoice id' do
    expect(page).to have_content(@invoice_item.invoice_id)
    expect(page).to have_content(@invoice_item2.invoice_id)
    expect(page).to have_content(@invoice_item3.invoice_id)
  end


end
