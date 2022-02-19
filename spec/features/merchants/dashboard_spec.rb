require 'rails_helper'

describe "Merchant Dashboard", type: :feature do
  before do
    @merchant = create(:merchant)
  end

  it 'displays the name of the merchant on the page' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content(@merchant.name)
  end

  it 'has a link to merchant item index' do
    visit "/merchants/#{@merchant.id}/dashboard"

    click_link("View store items")
    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
  end
end
