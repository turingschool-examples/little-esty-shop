require "rails_helper"
require 'time'
RSpec.describe 'Merchant Items index page' do
  it "shows all items when we visit the merchant items index" do
    mer_1 = create(:merchant)
    item_1 = create(:item, merchant_id: mer_1.id)
    item_2 = create(:item, merchant_id: mer_1.id)
    item_3 = create(:item, merchant_id: mer_1.id)
    item_4 = create(:item, merchant_id: mer_1.id)
    item_5 = create(:item, merchant_id: mer_1.id)
    item_6 = create(:item, merchant_id: mer_1.id)
    visit merchant_items_path(mer_1)
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_3.name)
    expect(page).to have_content(item_4.name)
    expect(page).to have_content(item_5.name)
    expect(page).to have_content(item_6.name)
  end

  it "can take me to a merchant items show page" do
    mer_1 = create(:merchant)
    item_1 = create(:item, merchant_id: mer_1.id)
      visit merchant_items_path(mer_1)
      expect(page).to have_link(item_1.name)
      click_link(item_1.name)
      expect(page).to have_current_path(merchant_item_path(mer_1, item_1))
  end

  it "has a button to disable or enable an item" do
    mer_1 = create(:merchant)
    item_1 = create(:item, merchant_id: mer_1.id, item_status: true)
    item_2 = create(:item, merchant_id: mer_1.id, item_status: false)

    visit merchant_items_path(mer_1)

    within("#item-#{item_1.id}") do
      expect(page).to have_button("Disable")
    end

    within("#item-#{item_2.id}") do
      expect(page).to have_button("Enable")
    end
  end

  it "when a button is clicked the status changes" do
    mer_1 = create(:merchant)
    item_1 = create(:item, merchant_id: mer_1.id, item_status: true)
    item_2 = create(:item, merchant_id: mer_1.id, item_status: false)

    visit merchant_items_path(mer_1)

    within("#item-#{item_1.id}") do
      click_button("Disable")
    end

    within("#item-#{item_1.id}") do
      expect(page).to have_button("Enable")
    end
  end
end
