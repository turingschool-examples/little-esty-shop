require 'rails_helper'

RSpec.describe 'Merchant Dashboard Page', type: :feature do
  before(:each) do
    # @merchant_1 = create(:merchant)
    visit merchant_dashboard_path(@merchant_1.id)
  end

  it 'has a header' do
    expect(page).to have_content('Merchant Dashboard')
  end

  it 'has the merchant name' do
    expect(page).to have_content(@merchant_1.name)
  end

  it 'has a link to the merchant items index' do
    expect(page).to have_link('Items Index')

    click_link('Items Index')

    expect(current_path).to eq(merchant_items_path(@merchant_1.id))
  end

  it 'has a link to the merchant invoices index' do
    expect(page).to have_link('Invoices Index')

    click_link('Invoices Index')

    expect(current_path).to eq(merchant_invoices_path(@merchant_1.id))
  end
end