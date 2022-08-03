require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  describe 'Items links' do
    it "can see a list of all my items and not items for other merchants" do
      merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Watch", description: "wearable", unit_price: 400, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Clock", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item4 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )
      item5 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )

      visit merchant_items_path(merchant1)

      expect(page).to have_content("Josey Wales")
      expect(page).to_not have_content("Britches Eckles")
      expect(page).to have_content("Camera")
      expect(page).to_not have_content("Bone")
    end

    it 'items are links' do
      merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item4 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )
      item5 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )

      visit merchant_items_path(merchant1)

      expect(page).to have_link('Camera')

      within("#enabled") do
        within(".merchant_item-#{item1.id}") do
          click_link "Camera"
        end
      end

    expect(current_path).to eq(merchant_items_path(merchant1, item1))
    end
  end

  it "has a link to create a new item" do
    merchant = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)

    visit merchant_items_path(merchant)

    expect(page).to have_link('Create New Item')

    click_on "Create New Item"

    expect(current_path).to eq(new_merchant_item_path(merchant))
  end

  describe 'Disable/Enable' do
    it 'shows/changes the items availiblity' do
      merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )

      visit merchant_items_path(merchant1)

      within("#enabled") do
        within(".merchant_item-#{item1.id}") do
          item = Item.find(item1.id)
          expect(item.availability).to eq("enable")
          expect(page).to have_button("Disable")
          expect(page).to_not have_button("Enable" )

          click_button "Disable"

          item = Item.find(item1.id)
          expect(item.availability).to eq("disable")
        end
      end

      within("#enabled") do
        within ".merchant_item-#{item2.id}" do
          item = Item.find(item2.id)
          expect(item.availability).to eq("enable")

          expect(page).to have_button("Disable")
          expect(page).to_not have_button("Enable" )

          click_button "Disable"
          item = Item.find(item2.id)
          expect(item.availability).to eq("disable")
        end
      end

      within("#enabled") do
        within ".merchant_item-#{item3.id}" do
          item = Item.find(item3.id)
          expect(item.availability).to eq("enable")

          expect(page).to have_button("Disable")
          expect(page).to_not have_button("Enable" )

          click_button "Disable"
          item = Item.find(item3.id)
          expect(item.availability).to eq("disable")
        end
      end

    end

    it 'has sections for enabled' do
      merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )

      visit merchant_items_path(merchant1)

      within('#enabled') do
        expect(page).to have_content ("Camera")
        expect(page).to have_content ("Bone")
        expect(page).to have_content ("Kong")
      end
    end

    it 'has section for disabled' do
      merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )

      visit merchant_items_path(merchant1)

      within("#enabled") do
        within(".merchant_item-#{item1.id}") do
          click_button "Disable"
        end
      end

      within("#enabled") do
        within(".merchant_item-#{item2.id}") do
          click_button "Disable"
        end
      end
      within("#enabled") do
        within(".merchant_item-#{item3.id}") do
          click_button "Disable"
        end
      end

      within('#disabled') do
        expect(page).to have_content("Camera")
        expect(page).to have_content("Bone")
        expect(page).to have_content("Kong")
      end
    end

    it 'groups by item availability status' do
      merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )

      visit merchant_items_path(merchant1)

      within("#enabled") do
        within(".merchant_item-#{item1.id}") do
          click_button "Disable"
        end
      end

      within("#enabled") do
        expect(page).to have_content("Bone")
        expect(page).to have_content("Kong")

        expect(page).to_not have_content("Camera")
      end

      within("#disabled") do
        expect(page).to have_content("Camera")

        expect(page).to_not have_content("Bone")
        expect(page).to_not have_content("Kong")
      end
    end
  end

  describe 'Most Popular Items' do
    it "can see the top 5 most popular items ranked by revenue" do
      merchant1 = Merchant.create!(name: "Josey Wales")
      merchant2 = Merchant.create!(name: "Britches Eckles")

      customer1 = Customer.create!(first_name: "Pipper", last_name: "Pots")

      invoice1 = Invoice.create!(customer_id: customer1.id, status: 1)
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 1)

      transaction1 = Transaction.create!(credit_card_number: 948756, result: 1, invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: 287502, result: 1, invoice_id: invoice1.id)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, merchant_id: merchant1.id)
      item2 = Item.create!(name: "Bone", description: "pet treats", unit_price: 200, merchant_id: merchant1.id)
      item3 = Item.create!(name: "Kong", description: "pet toys", unit_price: 100, merchant_id: merchant1.id)
      item4 = Item.create!(name: "Collar", description: "pet collar", unit_price: 300, merchant_id: merchant1.id)
      item5 = Item.create!(name: "Leash", description: "pet leash", unit_price: 400, merchant_id: merchant1.id)
      item6 = Item.create!(name: "Kibble", description: "pet food", unit_price: 600, merchant_id: merchant1.id)

      invoice_items1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 500, status: 0) #500
      invoice_items2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 2, unit_price: 200, status: 0) #400
      invoice_items3 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item3.id, quantity: 3, unit_price: 100, status: 1) #300
      invoice_items4 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item4.id, quantity: 2, unit_price: 100, status: 1) #600
      invoice_items5 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item5.id, quantity: 2, unit_price: 400, status: 2) #800
      invoice_items6 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item6.id, quantity: 2, unit_price: 600, status: 2) #1200

      visit merchant_items_path(merchant1)

      within("#top_5") do
        expect(item6.name).to appear_before(item5.name)
        expect(item5.name).to appear_before(item1.name)
        expect(item1.name).to appear_before(item2.name)
        expect(item2.name).to appear_before(item3.name)
        expect(page).to_not have_content(item4.name)
      end
    end

    it "can link top 5 items to the item show page" do
       merchant1 = Merchant.create!(name: "Josey Wales")
      merchant1 = Merchant.create!(name: "Britches Eckles")

      customer1 = Customer.create!(first_name: "Pipper", last_name: "Pots")

      invoice1 = Invoice.create!(customer_id: customer1.id, status: 1)
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 1)

      transaction1 = Transaction.create!(credit_card_number: 948756, result: 1, invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: 287502, result: 1, invoice_id: invoice1.id)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, merchant_id: merchant1.id)
      item2 = Item.create!(name: "Bone", description: "pet treats", unit_price: 200, merchant_id: merchant1.id)
      item3 = Item.create!(name: "Kong", description: "pet toys", unit_price: 100, merchant_id: merchant1.id)
      item4 = Item.create!(name: "Collar", description: "pet collar", unit_price: 300, merchant_id: merchant1.id)
      item5 = Item.create!(name: "Leash", description: "pet leash", unit_price: 400, merchant_id: merchant1.id)
      item6 = Item.create!(name: "Kibble", description: "pet food", unit_price: 600, merchant_id: merchant1.id)

      invoice_items1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 500, status: 0) #500
      invoice_items2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 2, unit_price: 200, status: 0) #400
      invoice_items3 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item3.id, quantity: 3, unit_price: 100, status: 1) #300
      invoice_items4 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item4.id, quantity: 2, unit_price: 100, status: 1) #600
      invoice_items5 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item5.id, quantity: 2, unit_price: 400, status: 2) #800
      invoice_items6 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item6.id, quantity: 2, unit_price: 600, status: 2) #1200

      visit merchant_items_path(merchant1)
      within("#top_5") do
        expect(page).to have_link(item5.name)
        expect(page).to have_link(item1.name)
        expect(page).to have_link(item2.name)
        expect(page).to have_link(item3.name)

        click_link "#{item1.name}"

        expect(current_path).to eq(merchant_item_path(merchant1, item1))
      end
    end
  end
end
