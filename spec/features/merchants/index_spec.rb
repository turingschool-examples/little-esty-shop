require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant1 = Merchant.create!(name: "Pabu")

    visit merchant_dashboard_index_path(@merchant1)
  end

  it 'shows merchant name' do
    expect(page).to have_content(@merchant1.name)
  end
  it 'has link to merchant item index' do
    within("#index-buttons") do
      click_button "Items Index"
      expect(current_path).to eq(merchant_items_path(@merchant1))
    end
  end
  it 'has link to merchant invoices index' do
    click_button "Invoices Index"
    expect(current_path).to eq(merchant_invoices_path(@merchant1))
  end
end
