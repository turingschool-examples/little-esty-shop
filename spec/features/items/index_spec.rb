require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before :each do
    @merchant1 = Merchant.create!(name: "Calvin Klein")
    @merchant2 = Merchant.create!(name: "Marc Jacobs")
    @merchant3 = Merchant.create!(name: "Yves Saint Laurent")

    @item1 = Item.create!(name: "T-shirts", description: "Blue" , unit_price: 12 , merchant_id: @merchant1.id)
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
    customer_2 = Customer.create!(first_name: "B", last_name: "B")

    invoice_1 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_2 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_3 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_4 = Invoice.create!(status: "completed", customer_id: customer_2.id)
    invoice_5 = Invoice.create!(status: "completed", customer_id: customer_2.id)
    invoice_6 = Invoice.create!(status: "completed", customer_id: customer_2.id) #failed

    transaction_1 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
    transaction_2 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_2.id)
    transaction_3 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
    transaction_4 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
    transaction_5 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
    transaction_6 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
    transaction_7 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id) #failed
    transaction_8 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
    transaction_9 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
    transaction_10 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
      
    merchant = Merchant.create!(name: "Wizards Chest")

    item_1 = Item.create!(name: "A", description: "A", unit_price: 100, merchant_id: merchant.id)
    item_2 = Item.create!(name: "B", description: "B", unit_price: 200, merchant_id: merchant.id)
    item_3 = Item.create!(name: "C", description: "C", unit_price: 300, merchant_id: merchant.id)
    item_4 = Item.create!(name: "D", description: "D", unit_price: 400, merchant_id: merchant.id)
    item_5 = Item.create!(name: "E", description: "E", unit_price: 500, merchant_id: merchant.id)
    item_6 = Item.create!(name: "F", description: "F", unit_price: 600, merchant_id: merchant.id)

    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: "shipped", quantity: 10, unit_price: 100)
    invoice_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: "shipped", quantity: 10, unit_price: 100) #2000
    invoice_item_3 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "shipped", quantity: 5, unit_price: 200)
    invoice_item_4 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "shipped", quantity: 5, unit_price: 200)
    invoice_item_5 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "shipped", quantity: 5, unit_price: 200) #3000
    invoice_item_6 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: "shipped", quantity: 5, unit_price: 300) #1500
    invoice_item_7 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: "shipped", quantity: 5, unit_price: 300)
    invoice_item_8 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: "shipped", quantity: 5, unit_price: 500) #4000
    invoice_item_9 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: "shipped", quantity: 5, unit_price: 500) #2500
    invoice_item_10 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, status: "shipped", quantity: 6, unit_price: 600) #3600 failed

    visit "/merchants/#{merchant.id}/items"


  end
end