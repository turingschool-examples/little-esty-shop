require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before :each do
    @merchant1 = Merchant.create!(name: "Calvin Klein")
    @merchant2 = Merchant.create!(name: "Marc Jacobs")
    @merchant3 = Merchant.create!(name: "Yves Saint Laurent")

    @item1 = Item.create!(name: "T-shirts", description: "Blue" , unit_price: 12 , merchant_id: @merchant1.id, status: 1)
    @item2 = Item.create!(name: "Shorts", description: "Green", unit_price: 45, merchant_id: @merchant2.id)
    @item3 = Item.create!(name: "Chinos", description: "White", unit_price: 67, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Hat", description: "Multicolor", unit_price: 84, merchant_id: @merchant2.id)
    @item5 = Item.create!(name:"Socks", description: "Grey", unit_price: 9, merchant_id: @merchant3.id)
    @item6 = Item.create!(name: "Sneakers", description: "Bone", unit_price: 122 , merchant_id: @merchant3.id)
  end

  describe 'As a merchant' do
    describe 'When i visit my merchant items index page' do
      it 'I see a list of the names of all of my items and i do not see items for any other merchant' do
        
        visit "/merchants/#{@merchant1.id}/items"

        within "#item-#{@item1.id}" do
          expect(page).to have_content(@item1.name)
        end

        within "#item-#{@item3.id}" do
          expect(page).to have_content(@item3.name)
        end
        
        expect(page).to_not have_content(@item2.name)
        expect(page).to_not have_content(@item4.name)
        expect(page).to_not have_content(@item5.name)
        expect(page).to_not have_content(@item6.name)
      end

      it 'i see a button next to each item name that will disable or enable that item. When I click this button then i am redirected back to the items index and i see that the items status has changed' do
        
        visit "/merchants/#{@merchant1.id}/items"

        within "#item-#{@item1.id}" do
          expect(page).to have_button("Enable Item")
        end
       
        within "#item-#{@item3.id}" do
          expect(page).to have_button("Disable Item")
        end

        within "#item-#{@item1.id}" do
          click_button "Enable Item"
        end

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
        expect(page).to have_content("T-shirts has been enabled.")

        within "#item-#{@item3.id}" do
          click_button "Disable Item"
        end

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
        expect(page).to have_content("Chinos has been disabled.")
       
      end
    end
    describe 'when i click on the name of an item from the merchant items index page' do
      it 'I am taken to that merchant items show page and i see all of the items attributes' do

        visit "/merchants/#{@merchant1.id}/items"

        expect(page).to have_link("T-shirts")
        expect(page).to have_link("Chinos")

        click_link 'T-shirts'

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")

        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item1.description)
        expect(page).to have_content(@item1.unit_price)
        expect(page).to_not have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
        expect(page).to_not have_content(@item4.name)
        expect(page).to_not have_content(@item5.name)
        expect(page).to_not have_content(@item6.name)
      end
    end
  end
end

RSpec.describe 'Merchant Items Index' do
  it 'displays 5 most popular item names ranked by total rev generated with links and total revenue' do
    customer_1 = Customer.create!(first_name: "A", last_name: "A")

    invoice_1 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_2 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_3 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_4 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_5 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_6 = Invoice.create!(status: "completed", customer_id: customer_1.id) #failed

    transaction_1 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
    transaction_2 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_2.id)
    transaction_3 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
    transaction_4 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
    transaction_5 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
    transaction_6 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
    transaction_7 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id) #both failed
        
    merchant = Merchant.create!(name: "Wizards Chest")

    item_1 = Item.create!(name: "A", description: "A", unit_price: 400, merchant_id: merchant.id)
    item_2 = Item.create!(name: "B", description: "B", unit_price: 200, merchant_id: merchant.id)
    item_3 = Item.create!(name: "C", description: "C", unit_price: 500, merchant_id: merchant.id)
    item_4 = Item.create!(name: "D", description: "D", unit_price: 100, merchant_id: merchant.id)
    item_5 = Item.create!(name: "E", description: "E", unit_price: 300, merchant_id: merchant.id)
    item_6 = Item.create!(name: "F", description: "F", unit_price: 600, merchant_id: merchant.id) #absent

    invoice_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: "shipped", quantity: 20, unit_price: 100) #2000
    invoice_item_5 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "shipped", quantity: 15, unit_price: 200) #3000
    invoice_item_6 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: "shipped", quantity: 5, unit_price: 300) #1500
    invoice_item_8 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: "shipped", quantity: 10, unit_price: 400) #4000
    invoice_item_9 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: "shipped", quantity: 5, unit_price: 500) #2500
    invoice_item_10 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, status: "shipped", quantity: 6, unit_price: 600) #3600 failed

    visit "/merchants/#{merchant.id}/items"

    within "#five-most-popular-items" do
      within "#topitems-0" do
        expect(page).to have_link("#{item_4.name}")
        expect(page).to have_content(" - $40.00 in sales")
      end

      within "#topitems-1" do
        expect(page).to have_link("#{item_2.name}")
        expect(page).to have_content(" - $30.00 in sales")
      end

      within "#topitems-2" do
        expect(page).to have_link("#{item_5.name}")
        expect(page).to have_content(" - $25.00 in sales")
      end

      within "#topitems-3" do
        expect(page).to have_link("#{item_1.name}")
        expect(page).to have_content(" - $20.00 in sales")
      end

      within "#topitems-4" do
        expect(page).to have_link("#{item_3.name}")
        expect(page).to have_content(" - $15.00 in sales")
      end
    end
  end

  it 'displays top items best day' do
    customer = Customer.create!(first_name: "A", last_name: "A")

    invoice_1 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-22 00:00:00 UTC") #failed
    invoice_2 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-22 00:00:00 UTC") #item2 7/22
    invoice_3 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-25 00:00:00 UTC")
    invoice_4 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-25 00:00:00 UTC")
    invoice_5 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-26 00:00:00 UTC")
    invoice_6 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-26 00:00:00 UTC") #item1 7/26
    invoice_7 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-28 00:00:00 UTC") #failed
    invoice_8 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-28 00:00:00 UTC") #failed

    transaction_1 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
    transaction_2 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_2.id)
    transaction_3 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
    transaction_4 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
    transaction_5 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
    transaction_6 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
    transaction_7 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_7.id)
    transaction_8 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_8.id)

    merchant = Merchant.create!(name: "Wizards Chest")

    item_1 = Item.create!(name: "A", description: "A", unit_price: 100, merchant_id: merchant.id)
    item_2 = Item.create!(name: "B", description: "B", unit_price: 200, merchant_id: merchant.id)

    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: "pending", quantity: 90, unit_price: 100)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "pending", quantity: 20, unit_price: 100) #2
    invoice_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_5.id, status: "pending", quantity: 5, unit_price: 100) #1
    invoice_item_4 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_6.id, status: "pending", quantity: 5, unit_price: 100) #1
    invoice_item_5 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, status: "pending", quantity: 90, unit_price: 100)
    invoice_item_6 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_8.id, status: "pending", quantity: 90, unit_price: 100)
    invoice_item_7 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_3.id, status: "pending", quantity: 5, unit_price: 100)
    invoice_item_8 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_4.id, status: "pending", quantity: 5, unit_price: 100)
    invoice_item_9 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_7.id, status: "pending", quantity: 90, unit_price: 100)
    invoice_item_10 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_8.id, status: "pending", quantity: 90, unit_price: 100)

    visit "/merchants/#{merchant.id}/items"

    within "#five-most-popular-items" do
      within "#topitems-0" do
        expect(page).to have_content("Top day for B was 07/22/22")
      end

      within "#topitems-1" do
        expect(page).to have_content("Top day for A was 07/26/22")
      end
    end
  end
end