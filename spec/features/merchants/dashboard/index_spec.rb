require 'rails_helper'

describe "Merchant Dashboard", type: :feature do
  before do
    @merchant1 = create(:merchant)

    visit "/merchants/#{@merchant1.id}"
  end

  it "displays the name of the merchant on the page" do
    expect(page).to have_content(@merchant1.name)
  end

  it "has a link to merchant item index" do
    click_link("View store items")

    expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
  end

  it 'has a link to merchant invoices index' do
    click_link "View invoices"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
  end

  it 'has items ready to ship section' do
    merchant2 = create(:merchant)

    item1 = create(:item, merchant: merchant2)
    item2 = create(:item, merchant: merchant2)

    # item 1 has already been shipped, do not display name
    ii1 = create(:invoice_item, status: "shipped", item: item1)

    # item 2 is packaged, display name
    ii2 = create(:invoice_item, status: "packaged", item: item2)
    ii3 = create(:invoice_item, status: "pending", item: item2)

    visit "/merchants/#{merchant2.id}"

    expect(page).to have_content("Items ready to ship")

    # sad path
    expect(page).not_to have_content(ii1.item.name)

    expect(page).to have_content(ii2.item.name)
    expect(page).to have_content(ii3.item.name)
  end

  it 'links to the invoice page for each ready invoice item' do
    merchant2 = create(:merchant)

    item1 = create(:item, merchant: merchant2)

    invoice1 = create(:invoice)
    invoice2 = create(:invoice)

    ii2 = create(:invoice_item, status: "packaged", item: item1, invoice: invoice1)
    ii3 = create(:invoice_item, status: "pending", item: item1, invoice: invoice2)

    visit "/merchants/#{merchant2.id}"

    within "#invoice_item-#{ii2.id}" do
      click_link "View invoice #{ii2.invoice.id}"
    end

    expect(current_path).to eq("/merchants/#{merchant2.id}/invoices/#{ii2.invoice.id}")

    # sad path
    expect(current_path).to_not eq("/merchants/#{merchant2.id}/invoices/#{ii3.invoice.id}")

    visit "/merchants/#{merchant2.id}"

    within "#invoice_item-#{ii3.id}" do
      click_link "View invoice #{ii3.invoice.id}"
    end

    expect(current_path).to eq("/merchants/#{merchant2.id}/invoices/#{ii3.invoice.id}")

    # sad path
    expect(current_path).to_not eq("/merchants/#{merchant2.id}/invoices/#{ii2.invoice.id}")
  end
end
