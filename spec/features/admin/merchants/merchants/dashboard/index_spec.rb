require 'rails_helper'

describe "Merchant Dashboard", type: :feature do
  before do
    @merchant = create(:merchant)

    visit "/merchants/#{@merchant.id}"
  end

  it 'displays the name of the merchant on the page' do
    expect(page).to have_content(@merchant.name)
  end

  it 'has a link to merchant item index' do
    click_link("View store items")

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
  end

  it 'has a link to merchant invoices index' do
    click_link "View invoices"

    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
  end
end
