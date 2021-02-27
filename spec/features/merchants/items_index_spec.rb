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

    within("#enabled_items-#{item_1.id}") do
      expect(page).to have_button("Disable")
    end

    within("#disabled_items-#{item_2.id}") do
      expect(page).to have_button("Enable")
    end
  end

  it "when a button is clicked the status changes" do
    mer_1 = create(:merchant)
    item_1 = create(:item, name:"item_1", merchant_id: mer_1.id, item_status: true)
    item_2 = create(:item, merchant_id: mer_1.id, item_status: false)

    visit merchant_items_path(mer_1)

    within("#enabled_items-#{item_1.id}") do
      click_button("Disable")
    end
    within("#disabled_items-#{item_1.id}") do
      expect(page).to have_button("Enable")
    end
  end

  it "will group by status for enable and disable" do
    mer_1 = create(:merchant)
    item_1 = create(:item, merchant_id: mer_1.id, item_status: true)
    item_2 = create(:item, merchant_id: mer_1.id, item_status: false)
    item_3 = create(:item, merchant_id: mer_1.id, item_status: true)

    item_4 = create(:item, merchant_id: mer_1.id,item_status: false)
    item_5 = create(:item, merchant_id: mer_1.id, item_status: true)
    item_6 = create(:item, merchant_id: mer_1.id, item_status: false)
    visit merchant_items_path(mer_1)
    within("#enabled_items-#{item_1.id}") do
      expect(page).to have_content(item_1.name)
    end
      within("#enabled_items-#{item_3.id}") do
      expect(page).to have_content(item_3.name)
    end
    within("#disabled_items-#{item_2.id}") do
      expect(page).to have_content(item_2.name)
      expect(page).not_to have_content(item_4.id)
    end
      within("#disabled_items-#{item_4.id}") do
      expect(page).to have_content(item_4.name)
      expect(page).not_to have_content(item_1.name)
    end

  end

  it "can show the top five items for a specific merchant" do
    mer_1 = create(:merchant)
    cust_1 = create(:customer)
    cust_2 = create(:customer)
    cust_3 = create(:customer)
    cust_4 = create(:customer)
    cust_5 = create(:customer)
    cust_6 = create(:customer)
    cust_7 = create(:customer)
    cust_8 = create(:customer)
    cust_9 = create(:customer)
    cust_10 = create(:customer)
    item_1 = create(:item, name: "item_1", merchant_id: mer_1.id)
    item_2 = create(:item, name: "item_2", merchant_id: mer_1.id)
    item_3 = create(:item, name: "item_3", merchant_id: mer_1.id)
    item_4 = create(:item, name:"item_4", merchant_id: mer_1.id)
    item_5 = create(:item,name: "item_5", merchant_id: mer_1.id)
    item_6 = create(:item,name: "item_6", merchant_id: mer_1.id)
    item_7 = create(:item,name: "item_7", merchant_id: mer_1.id)
    item_8 = create(:item,name: "item_8", merchant_id: mer_1.id)
    item_9 = create(:item,name: "item_9", merchant_id: mer_1.id)
    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_5.id)
    invoice6 = create(:invoice, customer_id: cust_6.id)
    invoice7 = create(:invoice, customer_id: cust_7.id)
    invoice8 = create(:invoice, customer_id: cust_8.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2)
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice3.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item5 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice5.id, quantity: 1, unit_price:2)
    invoice_item6 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice6.id, quantity: 10, unit_price:10)
    invoice_item7 = create(:invoice_item, item_id:item_7.id, invoice_id:invoice7.id, quantity: 1, unit_price:1)
    invoice_item8 = create(:invoice_item, item_id:item_8.id, invoice_id:invoice8.id, quantity: 1, unit_price: 1)
    transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id)
    transaction2 = create(:transaction, result: "success", invoice_id: invoice7.id)
    transaction2 = create(:transaction, result: "success", invoice_id: invoice3.id)
    transaction3 = create(:transaction, result: "success", invoice_id: invoice8.id)
    transaction4 = create(:transaction, result: "success", invoice_id: invoice4.id)
    transaction5 = create(:transaction, result: "success", invoice_id: invoice5.id)
    transaction8 = create(:transaction, result: "success", invoice_id: invoice6.id)
      visit merchant_items_path(mer_1)
    expect(page).to have_content("Top Five Items by Revenue")
    within("#topitems-") do
      expect(page).to have_content(item_6.name)
      expect(item_6.name).to appear_before(item_2.name)
      expect(item_2.name).to appear_before(item_1.name)
      expect(item_1.name).to appear_before(item_4.name)
      expect(item_4.name).to appear_before(item_5.name)
      expect(page).not_to have_content(item_9.name)
      expect(page).not_to have_content(item_8.name)
      expect(page).to have_content(100)
      expect(page).to have_content(60)
      expect(page).to have_content(16)
      expect(page).to have_content(15)
      expect(page).to have_content(2)
    end
  end
end
