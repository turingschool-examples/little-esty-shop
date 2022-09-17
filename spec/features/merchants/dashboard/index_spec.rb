require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index' do
  before :each do
    @merchant = create(:merchant)
    visit merchant_dashboard_index_path(@merchant.id)
  end

  it 'lists the merchant name' do
    expect(page).to have_content(@merchant.name)
  end

  it 'has a link to merchant items index' do
    expect(page).to have_link("My Items")

    click_link("My Items")

    expect(current_path).to eq(merchant_items_path(@merchant.id))
  end

  it 'has a link to merchant invoices index' do
    expect(page).to have_link("My Invoices")

    click_link("My Invoices")
    
    expect(current_path).to eq(merchant_invoices_path(@merchant.id))
  end
end