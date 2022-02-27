require 'rails_helper'

RSpec.describe 'merchant item index', type: :feature do
  it 'displays all items' do
    merchant = create(:merchant)

    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)

    visit "/merchants/#{merchant.id}/items"

    expect(page).to have_content(item1.name)
    expect(page).to have_content(item2.name)
    expect(page).to have_content(item3.name)
  end

  it 'has links to each items show page' do
    merchant = create(:merchant)

    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)

    visit "/merchants/#{merchant.id}/items"

    within "#item-#{item2.id}" do
      click_button "View item"
    end

    expect(current_path).to eq("/merchants/#{merchant.id}/items/#{item2.id}")
  end

  it 'can toggle the status from the index page' do
    merchant = create(:merchant)

    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)

    visit "/merchants/#{merchant.id}/items"


    within "#item-#{item1.id}" do

      expect(item1.status).to eq("disabled")

      click_button "enable"
      item1.reload

      expect(item1.status).to eq("enabled")
      expect(page).to have_content("enabled")
    end

    expect(page).to have_content("Item status updated!")
  end

  it 'after toggling the item will display in the correct column.' do
    merchant = create(:merchant)

    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)

    visit "/merchants/#{merchant.id}/items"
    within "#item-#{item1.id}" do
      expect(item1.status).to eq("disabled")

      click_button "enable"
      item1.reload
    end
    within("#enabled") do
      expect(item1.status).to eq("enabled")
      expect(page).to have_content("enabled")
    end

    within "#item-#{item2.id}" do
      expect(item2.status).to eq("disabled")
      click_button "enable"
      item2.reload
    end
    within("#enabled") do
      expect(item2.status).to eq("enabled")
    end
    expect(page).to have_content("Item status updated!")
  end


  it "Lists the top five selling items for the merchant" do
    merchant1 = Merchant.create!(name: "The Tornado")
    item1 = merchant1.items.create!(name: "SmartPants", description: "IQ + 20", unit_price: 120)
    item2 = merchant1.items.create!(name: "FunPants", description: "Cha + 20", unit_price: 2000)
    item3 = merchant1.items.create!(name: "FitPants", description: "Con + 20", unit_price: 150)
    item4 = merchant1.items.create!(name: "VeinyShorts", description: "Str + 20", unit_price: 1400)
    item5 = merchant1.items.create!(name: "SpringSocks", description: "DX + 20", unit_price: 375)
    item6 = merchant1.items.create!(name: "UnderRoos", description: "SNUG!", unit_price: 25)
    item7 = merchant1.items.create!(name: "SunStoppers", description: "Eclipse ready!", unit_price: 50)
    customer1 = Customer.create!(first_name: "Marky", last_name: "Mark" )
    customer2 = Customer.create!(first_name: "Larky", last_name: "Lark" )
    customer3 = Customer.create!(first_name: "Sparky", last_name: "Spark" )
    customer4 = Customer.create!(first_name: "Farky", last_name: "Fark" )
    invoice1 = customer1.invoices.create!(status: 0)
    invoice2 = customer2.invoices.create!(status: 0)
    invoice3 = customer3.invoices.create!(status: 0)


    invoice_item2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 2, unit_price: 2000, status: 0)
    invoice_item4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item1.id, quantity: 2, unit_price: 120, status: 1)
    invoice_item7 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item7.id, quantity: 15, unit_price: 50, status: 2)
    invoice_item3 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item3.id, quantity: 5, unit_price: 125, status: 0)
    invoice_item1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 125, status: 0)
    invoice_item6 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item6.id, quantity: 20, unit_price: 25, status: 2)
    invoice_item5 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 2, unit_price: 2000, status: 1)
    invoice_item8 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 1, unit_price: 2000, status: 1)
    invoice_item9 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item4.id, quantity: 3, unit_price: 1400, status: 2)

    visit "/merchants/#{merchant1.id}/items"
    within("#top-five") do
      expect(page).to have_content("FunPants")
      expect("FunPants").to appear_before("VeinyShorts")
      expect("Revenue Generated: 10000").to appear_before("Revenue Generated: 4200")
      expect("VeinyShorts").to appear_before("SunStoppers")
      expect(page).to_not have_content("SpringSocks")
      expect(page).to_not have_content("SmartPants")
      save_and_open_page
      click_link("#{item2.name}")
      expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item2.id}")

    end
  end

end
