require 'rails_helper'

RSpec.describe 'Merchants Items Index' do
  describe "A merchants' items' names" do
    it 'shows the names of the items a merchant has and no other' do
      merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      item1 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item2 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item3 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch2.id)
      item4 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item5 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch2.id)

      visit merchant_items_path(merch1)

      within '.items' do
        expect(page).to have_content("#{item1.name}")
        expect(page).to have_content("#{item2.name}")
        expect(page).to_not have_content("#{item3.name}")
        expect(page).to have_content("#{item4.name}")
        expect(page).to_not have_content("#{item5.name}")
      end
    end
  end


  describe 'Items can be grouped by status' do
    it 'items are in enabled_section that match their status' do
      merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      item1 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item2 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item3 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item4 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item5 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)

      visit merchant_items_path(merch1)

      # within '.items' do
      #   within '.enabled-items' do
      #   end
      # end
    end
  end

  describe '5 most popular items' do

    before :each do
      @merchant1 = Merchant.create!(name: "Mia")

      @customer1 = Customer.create!(first_name: "Iron", last_name: "Man")

      @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 1) #completed
      @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 1) # completed

      @transaction1 = Transaction.create!(credit_card_number: 948756, result: 1, invoice_id: @invoice1.id) #result succesful
      @transaction2 = Transaction.create!(credit_card_number: 287502, result: 1, invoice_id: @invoice2.id) #result succesful

      @item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, merchant_id: @merchant1.id) # 3.
      @item2 = Item.create!(name: "Bone", description: "pet treats", unit_price: 200, merchant_id: @merchant1.id) # 4.
      @item3 = Item.create!(name: "Kong", description: "pet toys", unit_price: 100, merchant_id: @merchant1.id) # 5.
      @item4 = Item.create!(name: "Collar", description: "pet collar", unit_price: 300, merchant_id: @merchant1.id) # 6.
      @item5 = Item.create!(name: "Leash", description: "pet leash", unit_price: 400, merchant_id: @merchant1.id) # 2.
      @item6 = Item.create!(name: "Kibble", description: "pet food", unit_price: 600, merchant_id: @merchant1.id) # 1.

      @invoice_items1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 500, status: 0) #revenue = 500
      @invoice_items2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 2, unit_price: 200, status: 0) #revenue = 400
      @invoice_items3 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item3.id, quantity: 3, unit_price: 100, status: 1) #revenue = 300
      @invoice_items4 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item4.id, quantity: 2, unit_price: 100, status: 1) #revenue = 200
      @invoice_items5 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item5.id, quantity: 2, unit_price: 400, status: 2) #revenue = 800
      @invoice_items6 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item6.id, quantity: 2, unit_price: 600, status: 2) #revenue = 1200
    end

    it 'shows the 5 most popular items by name' do
      visit merchant_items_path(@merchant1)

      within ".top_5_items" do
        expect(page).to have_content("#{@item1.name}")
        expect(page).to have_content("#{@item2.name}")
        expect(page).to_not have_content("#{@item4.name}")
        expect(page).to have_content("#{@item3.name}")
        expect(page).to have_content("#{@item5.name}")
        expect(page).to have_content("#{@item6.name}")
      end
    
      within ".top_5_items" do
        within "#top_5_item-#{@item1.id}" do
          expect(page).to have_content("#{@item1.name}")
        end
      end

    end

    it 'the names have a link to the item show page' do
      visit merchant_items_path(@merchant1)

      within ".top_5_items" do
        within "#top_5_item-#{@item1.id}" do
          expect(page).to have_link("#{@item1.name}")
          click_link "#{@item1.name}"
        end
      end

      expect(current_path).to eq(merchant_item(@merchant1, @item1))
    end
    
    it 'next to the name there is the total revenue of that item'
    it 'ranks the popular items in desc order'
  end
end