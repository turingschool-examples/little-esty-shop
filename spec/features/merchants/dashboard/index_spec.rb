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

  it 'has items ready to ship section' do
    merchant2 = create(:merchant)

    item1 = create(:item, merchant: merchant2)
    item2 = create(:item, merchant: merchant2)

    # item 1 has already been shipped, do not display name
    ii1 = create(:invoice_item, status: "shipped", item: item1)
    
    # item 2 is packaged, display name
    ii2 = create(:invoice_item, status: "packaged", item: item2)
    ii3 = create(:invoice_item, status: "packaged", item: item2)

    visit "/merchants/#{merchant2.id}"

    expect(page).to have_content("Items ready to ship")

    expect(page).not_to have_content(ii1.item.name)

    expect(page).to have_content(ii2.item.name)
    expect(page).to have_content(ii3.item.name)
  end
end
