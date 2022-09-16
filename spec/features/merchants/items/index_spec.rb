require 'rails_helper'

RSpec.describe 'Merchants Items Index' do
  describe "A merchants' items' names" do
    it 'shows the names of the items a merchant has and no other' do
      merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      item1 = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2), unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item2 = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2), unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item3 = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2), unit_price:Faker::Number.number(digits: 5), merchant_id: merch2.id)
      item4 = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2), unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item5 = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2), unit_price:Faker::Number.number(digits: 5), merchant_id: merch2.id)

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

      item1 = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2), unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item2 = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2), unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item3 = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2), unit_price:Faker::Number.number(digits: 5), merchant_id: merch2.id)
      item4 = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2), unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item5 = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2), unit_price:Faker::Number.number(digits: 5), merchant_id: merch2.id)

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
      @invoice3 = Invoice.create!(customer_id: @customer1.id, status: 1) # completed

      @transaction1 = Transaction.create!(credit_card_number: 948756, result: 0, invoice_id: @invoice1.id) #result succesful
      @transaction2 = Transaction.create!(credit_card_number: 287502, result: 0, invoice_id: @invoice2.id) #result succesful
      @transaction3 = Transaction.create!(credit_card_number: 287502, result: 1, invoice_id: @invoice3.id) #result failure

      @item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, merchant_id: @merchant1.id) # 3.
      @item2 = Item.create!(name: "Bone", description: "pet treats", unit_price: 200, merchant_id: @merchant1.id) # 4.
      @item3 = Item.create!(name: "Kong", description: "pet toys", unit_price: 100, merchant_id: @merchant1.id) # 5.
      @item4 = Item.create!(name: "Collar", description: "pet collar", unit_price: 300, merchant_id: @merchant1.id) # 6.
      @item5 = Item.create!(name: "Leash", description: "pet leash", unit_price: 400, merchant_id: @merchant1.id) # 2.
      @item6 = Item.create!(name: "Kibble", description: "pet food", unit_price: 600, merchant_id: @merchant1.id) # 1.
      @item7 = Item.create!(name: "Failed", description: "Failed", unit_price: 600, merchant_id: @merchant1.id) # 1.

      @invoice_items1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 500, status: 0) #revenue = 500
      @invoice_items2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 2, unit_price: 200, status: 0) #revenue = 400
      @invoice_items3 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item3.id, quantity: 3, unit_price: 100, status: 1) #revenue = 300
      @invoice_items4 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item4.id, quantity: 2, unit_price: 100, status: 1) #revenue = 200
      @invoice_items5 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item5.id, quantity: 2, unit_price: 400, status: 2) #revenue = 800
      @invoice_items6 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item6.id, quantity: 2, unit_price: 600, status: 2) #revenue = 1200
      @invoice_items7 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item7.id, quantity: 2, unit_price: 600, status: 2) #revenue = 1200
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
        expect(page).to_not have_content("#{@item7.name}")
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

      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
    end
    
    it 'next to the name there is the total revenue of that item' do
      visit merchant_items_path(@merchant1)

      within ".top_5_items" do
        within "#top_5_item-#{@item1.id}" do
          expect(page).to have_content("$5.00")
        end
      end
    end

    it 'ranks the popular items in desc order' do
      visit merchant_items_path(@merchant1)

      within ".top_5_items" do
        expect(@item6.name).to appear_before(@item5.name)
        expect(@item5.name).to appear_before(@item1.name)
        expect(@item1.name).to appear_before(@item2.name)
        expect(@item2.name).to appear_before(@item3.name)
        expect(@item3.name).to_not appear_before(@item6.name)
        expect(page).to_not have_content(@item4.name)
      end
    end
  end

  describe 'top items best day' do

    before :each do
      @merchant = create(:merchant)
      @customers = create_list(:customer, 3)

      @cus1_invoice = @customers[0].invoices.create(attributes_for(:invoice))
      @cus2_invoice = @customers[1].invoices.create(attributes_for(:invoice))
      @cus3_invoice = @customers[2].invoices.create(attributes_for(:invoice))
     
      @inv1_trans = @cus1_invoice.transactions.create(attributes_for(:transaction, result: 0))
      @inv2_trans = @cus2_invoice.transactions.create(attributes_for(:transaction, result: 0))
      @inv3_trans = @cus3_invoice.transactions.create(attributes_for(:transaction, result: 0))

      @item1 = @merchant.items.create(attributes_for(:item))
      @item2 = @merchant.items.create(attributes_for(:item))
      @item3 = @merchant.items.create(attributes_for(:item))
      @item4 = @merchant.items.create(attributes_for(:item))
      @item5 = @merchant.items.create(attributes_for(:item))
      @item6 = @merchant.items.create(attributes_for(:item))
      @item7 = @merchant.items.create(attributes_for(:item))
      # @item8 = @merchant.items.create(attributes_for(:item))
      # @item9 = @merchant.items.create(attributes_for(:item))
      @item10 = @merchant.items.create(attributes_for(:item))

      @inv_item1 = create(:invoice_item, invoice_id: @cus1_invoice.id, item_id: @item1.id, quantity: 1, unit_price: @item1.unit_price)
      @inv_item2 = create(:invoice_item, invoice_id: @cus1_invoice.id, item_id: @item2.id, quantity: 1, unit_price: @item2.unit_price)
      @inv_item3 = create(:invoice_item, invoice_id: @cus1_invoice.id, item_id: @item3.id, quantity: 1, unit_price: @item3.unit_price)
      @inv_item4 = create(:invoice_item, invoice_id: @cus1_invoice.id, item_id: @item4.id, quantity: 1, unit_price: @item4.unit_price)
      @inv_item5 = create(:invoice_item, invoice_id: @cus1_invoice.id, item_id: @item5.id, quantity: 1, unit_price: @item5.unit_price)

      @inv_item6 = create(:invoice_item, invoice_id: @cus2_invoice.id, item_id: @item6.id, quantity: 1, unit_price: @item6.unit_price)
      @inv_item7 = create(:invoice_item, invoice_id: @cus2_invoice.id, item_id: @item7.id, quantity: 1, unit_price: @item7.unit_price)
      @inv_item8 = create(:invoice_item, invoice_id: @cus2_invoice.id, item_id: @item1.id, quantity: 1, unit_price: @item1.unit_price)
      @inv_item9 = create(:invoice_item, invoice_id: @cus2_invoice.id, item_id: @item1.id, quantity: 1, unit_price: @item1.unit_price)
      @inv_item10 = create(:invoice_item, invoice_id:@cus2_invoice.id, item_id: @item10.id, quantity: 1, unit_price: @item10.unit_price)

      @inv_item11 = create(:invoice_item, invoice_id: @cus3_invoice.id, item_id: @item1.id, quantity: 1, unit_price: @item1.unit_price)
      @inv_item12 = create(:invoice_item, invoice_id: @cus3_invoice.id, item_id: @item1.id, quantity: 1, unit_price: @item1.unit_price)
      @inv_item13 = create(:invoice_item, invoice_id: @cus3_invoice.id, item_id: @item2.id, quantity: 1, unit_price: @item2.unit_price)
      @inv_item14 = create(:invoice_item, invoice_id: @cus3_invoice.id, item_id: @item2.id, quantity: 1, unit_price: @item2.unit_price)
      @inv_item15 = create(:invoice_item, invoice_id: @cus3_invoice.id, item_id: @item2.id, quantity: 1, unit_price: @item2.unit_price)
    end

    it 'shows the best/most recent day item sold' do
      visit merchant_items_path(@merchant)

      date = @cus3_invoice.created_at.strftime("%-m/%-d/%Y")

      within ".top_5_items" do
        within "#top_5_item-#{@item1.id}" do
          expect(page).to have_content("Top Selling Date #{@item1.name} was #{date}")
        end
      end
    end

  end
end