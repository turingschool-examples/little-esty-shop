require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'instance methods' do
    it 'has favorite customers' do
      customer_1 = Customer.create!(first_name: "A", last_name: "A")
      customer_2 = Customer.create!(first_name: "B", last_name: "B")
      customer_3 = Customer.create!(first_name: "C", last_name: "C")
      customer_4 = Customer.create!(first_name: "D", last_name: "D")
      customer_5 = Customer.create!(first_name: "E", last_name: "E")
      customer_6 = Customer.create!(first_name: "F", last_name: "F")

      invoice_1 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: "completed", customer_id: customer_2.id)
      invoice_3 = Invoice.create!(status: "completed", customer_id: customer_3.id)
      invoice_4 = Invoice.create!(status: "completed", customer_id: customer_4.id)
      invoice_5 = Invoice.create!(status: "completed", customer_id: customer_5.id)
      invoice_6 = Invoice.create!(status: "completed", customer_id: customer_6.id)

      transaction_1 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
      transaction_2 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
      transaction_3 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
      transaction_4 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
      transaction_5 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
      transaction_6 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
      transaction_7 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
      transaction_8 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
      transaction_9 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
      transaction_10 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
      transaction_11 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
      transaction_12 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
      transaction_13 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
      transaction_14 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
      transaction_15 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_2.id)
      transaction_16 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
      transaction_17 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
      transaction_18 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
      transaction_19 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
      transaction_20 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
      transaction_21 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)

      merchant = Merchant.create!(name: "Wizards Chest")

      item = Item.create!(name: "A", description: "A", unit_price: 100, merchant_id: merchant.id)

      invoice_item_1 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_1.id, status: "shipped", quantity: 5, unit_price: 100)
      invoice_item_2 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_2.id, status: "shipped", quantity: 5, unit_price: 100)
      invoice_item_3 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_3.id, status: "shipped", quantity: 5, unit_price: 100)
      invoice_item_4 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_4.id, status: "shipped", quantity: 5, unit_price: 100)
      invoice_item_5 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_5.id, status: "shipped", quantity: 5, unit_price: 100)
      invoice_item_6 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_6.id, status: "shipped", quantity: 5, unit_price: 100)

      expect(merchant.favorite_customers).to eq([customer_6, customer_5, customer_4, customer_3, customer_2])
    end

    it 'has item invoices ready to ship' do
      customer_1 = Customer.create!(first_name: "A", last_name: "A")

      invoice_1 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_3 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_4 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_5 = Invoice.create!(status: "completed", customer_id: customer_1.id)

      merchant = Merchant.create!(name: "Wizards Chest")

      item_1 = Item.create!(name: "A", description: "A", unit_price: 100, merchant_id: merchant.id)
      item_2 = Item.create!(name: "B", description: "B", unit_price: 200, merchant_id: merchant.id)
      item_3 = Item.create!(name: "C", description: "C", unit_price: 300, merchant_id: merchant.id)
      item_4 = Item.create!(name: "D", description: "D", unit_price: 400, merchant_id: merchant.id)
      item_5 = Item.create!(name: "E", description: "E", unit_price: 500, merchant_id: merchant.id)

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: "packaged", quantity: 5, unit_price: 100)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "pending", quantity: 5, unit_price: 100)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: "shipped", quantity: 5, unit_price: 100)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: "shipped", quantity: 5, unit_price: 100)
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: "pending", quantity: 5, unit_price: 100)

      expect(merchant.ready_to_ship).to eq([invoice_item_1, invoice_item_2, invoice_item_5])
      expect(merchant.ready_to_ship.first.item).to eq(item_1)
      expect(merchant.ready_to_ship.last.invoice).to eq(invoice_5)
    end

      it 'find_all_by_status will return all enabled items' do
        @merchant1 = Merchant.create!(name: "Calvin Klein")

        @item1 = Item.create!(name: "T-shirts", description: "Blue" , unit_price: 12 , merchant_id: @merchant1.id, status: 1)
        @item2 = Item.create!(name: "Shorts", description: "Green", unit_price: 45, merchant_id: @merchant1.id, status: 0)
        @item3 = Item.create!(name: "Chinos", description: "White", unit_price: 67, merchant_id: @merchant1.id, status: 1)
        @item4 = Item.create!(name: "Hat", description: "Multicolor", unit_price: 84, merchant_id: @merchant1.id, status: 0)
        @item5 = Item.create!(name:"Socks", description: "Grey", unit_price: 9, merchant_id: @merchant1.id, status: 1)
        @item6 = Item.create!(name: "Sneakers", description: "Bone", unit_price: 122 , merchant_id: @merchant1.id, status: 0)

        expect(@merchant1.find_all_by_status(0)).to eq([@item2, @item4, @item6])
      end

    it 'can return_by_status_enabled' do
      merchant_1 = Merchant.create!(name: "Wizards Chest")
      merchant_2 = Merchant.create!(name: "Tattered Cover")
      merchant_3 = Merchant.create!(name: "Powell's City of Books", status: 'disabled')

      expect(Merchant.all.return_by_status_enabled).to eq([merchant_1, merchant_2])
      expect(Merchant.all.return_by_status_enabled).to_not eq([merchant_3])
    end

    it 'can return_by_status_disabled' do
      merchant_1 = Merchant.create!(name: "Wizards Chest")
      merchant_2 = Merchant.create!(name: "Tattered Cover", status: 'disabled')
      merchant_3 = Merchant.create!(name: "Powell's City of Books", status: 'disabled')

      expect(Merchant.all.return_by_status_disabled).to eq([merchant_2, merchant_3])
      expect(Merchant.all.return_by_status_disabled).to_not eq([merchant_1])
    end

    it 'has five_most_popular_items' do
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

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: "shipped", quantity: 20, unit_price: 100) #2000 4
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "shipped", quantity: 15, unit_price: 200) #3000 2
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: "shipped", quantity: 5, unit_price: 300) #1500 5
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: "shipped", quantity: 10, unit_price: 400) #4000 1
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: "shipped", quantity: 5, unit_price: 500) #2500 3
      invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, status: "shipped", quantity: 6, unit_price: 600) #3600 failed

      expect(merchant.five_most_popular_items).to eq([item_4, item_2, item_5, item_1, item_3])
    end

    it 'has five_top_merchants_by_revenue' do
      customer_1 = Customer.create!(first_name: "A", last_name: "A")

      invoice_1 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_3 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_4 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_5 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_6 = Invoice.create!(status: "completed", customer_id: customer_1.id)

      transaction_1 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
      transaction_2 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_2.id)
      transaction_3 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
      transaction_4 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
      transaction_5 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
      transaction_6 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
      transaction_7 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id) #both failed
        
      merchant_1 = Merchant.create!(name: "Wizards Chest")
      merchant_2 = Merchant.create!(name: "Pirates Chest")
      merchant_3 = Merchant.create!(name: "Pokemon Chest")
      merchant_4 = Merchant.create!(name: "Dungeons and Dragons Store")
      merchant_5 = Merchant.create!(name: "Star Trek Store")
      merchant_6 = Merchant.create!(name: "Star Wars Store")

      item_1 = Item.create!(name: "A", description: "A", unit_price: 400, merchant_id: merchant_1.id) #2000
      item_2 = Item.create!(name: "B", description: "B", unit_price: 200, merchant_id: merchant_2.id) #3000
      item_3 = Item.create!(name: "C", description: "C", unit_price: 500, merchant_id: merchant_3.id) #1500
      item_4 = Item.create!(name: "D", description: "D", unit_price: 100, merchant_id: merchant_4.id) #4000
      item_5 = Item.create!(name: "E", description: "E", unit_price: 300, merchant_id: merchant_5.id) #2500
      item_6 = Item.create!(name: "F", description: "F", unit_price: 600, merchant_id: merchant_6.id) #3600


      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: "shipped", quantity: 20, unit_price: 100) #2000
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "shipped", quantity: 15, unit_price: 200) #3000
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: "shipped", quantity: 5, unit_price: 300) #1500
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: "shipped", quantity: 10, unit_price: 400) #4000
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: "shipped", quantity: 5, unit_price: 500) #2500
      invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, status: "shipped", quantity: 6, unit_price: 600) #3600

      expect(Merchant.five_top_merchants_by_revenue).to eq([merchant_4, merchant_2, merchant_5, merchant_1, merchant_3])
    end

    it 'has best revenue day' do
      customer = Customer.create!(first_name: "A", last_name: "A")

      invoice_1 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-22 00:00:00 UTC") #failed
      invoice_2 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-22 00:00:00 UTC")
      invoice_3 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-25 00:00:00 UTC") #best day 7/25
      invoice_4 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-25 00:00:00 UTC")
      invoice_5 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-26 00:00:00 UTC")
      invoice_6 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-28 00:00:00 UTC") #failed

      transaction_1 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
      transaction_2 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_2.id)
      transaction_3 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
      transaction_4 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
      transaction_5 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
      transaction_6 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)

      merchant = Merchant.create!(name: "Wizards Chest")

      item = Item.create!(name: "A", description: "A", unit_price: 200, merchant_id: merchant.id)

      invoice_item_1 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_1.id, status: "pending", quantity: 90, unit_price: 100) # 9000 fail
      invoice_item_2 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_2.id, status: "pending", quantity: 21, unit_price: 100) # 2100
      invoice_item_3 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_3.id, status: "pending", quantity: 15, unit_price: 100) # 2500
      invoice_item_4 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_4.id, status: "pending", quantity: 10, unit_price: 100) # ^
      invoice_item_5 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_5.id, status: "pending", quantity: 20, unit_price: 100) # 2000
      invoice_item_6 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_6.id, status: "pending", quantity: 90, unit_price: 100) # 9000 fail

      expect(merchant.best_revenue_day).to eq(invoice_3.created_at.strftime("%m/%d/%y"))
      expect(merchant.best_revenue_day).to eq(invoice_4.created_at.strftime("%m/%d/%y"))
    end
  end
end
