require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
  end

  describe 'instance variables' do

    describe '.invoices' do
      it 'returns a list of invoices which contain an item from the merchant' do
        merchant_1 = create(:merchant)
        item_1 = create(:item, merchant: merchant_1)
        item_2 = create(:item, merchant: merchant_1)

        merchant_2 = create(:merchant)
        item_3 = create(:item, merchant: merchant_2)
        item_4 = create(:item, merchant: merchant_2)

        invoice_1 = create(:invoice)
        invoice_2 = create(:invoice)
        invoice_3 = create(:invoice)
        invoice_4 = create(:invoice)

        invoice_1.items << [item_1, item_2, item_3]
        invoice_2.items << [item_3, item_4]
        invoice_3.items << [item_1, item_4]
        invoice_4.items << item_2
        expect(merchant_1.distinct_invoices).to match_array([invoice_1, invoice_3, invoice_4])
        expect(merchant_2.distinct_invoices).to match_array([invoice_1, invoice_2, invoice_3])
      end
    end

    describe 'top 5 customers' do
      before :each do
        @customer_1 = create(:customer)
        @customer_2 = create(:customer)
        @customer_3 = create(:customer)
        @customer_4 = create(:customer)
        @customer_5 = create(:customer)
        @customer_6 = create(:customer)
        @customer_7 = create(:customer)
        @customer_8 = create(:customer)
        
        @invoice_1 = create(:invoice, customer: @customer_1)
        @invoice_2 = create(:invoice, customer: @customer_2)
        @invoice_3 = create(:invoice, customer: @customer_3)
        @invoice_4 = create(:invoice, customer: @customer_4)
        @invoice_5 = create(:invoice, customer: @customer_5)
        @invoice_6 = create(:invoice, customer: @customer_6)
        @invoice_7 = create(:invoice, customer: @customer_7)
        @invoice_8 = create(:invoice, customer: @customer_8)
        @invoice_9 = create(:invoice, customer: @customer_5)
        @invoice_10 = create(:invoice, customer: @customer_6)
        @invoice_11 = create(:invoice, customer: @customer_4)
        @invoice_12 = create(:invoice, customer: @customer_4)
        @invoice_13 = create(:invoice, customer: @customer_4)
        @invoice_14 = create(:invoice, customer: @customer_6)
        @invoice_15 = create(:invoice, customer: @customer_4)
        @invoice_16 = create(:invoice, customer: @customer_4)
        @invoice_17 = create(:invoice, customer: @customer_5)
        @invoice_18 = create(:invoice,customer: @customer_5)
        @invoice_19 = create(:invoice,customer: @customer_6)
        @invoice_20 = create(:invoice,customer: @customer_6)
        @invoice_21 = create(:invoice,customer: @customer_7)
        @invoice_22 = create(:invoice,customer: @customer_7)
        @invoice_23 = create(:invoice,customer: @customer_8)

        @merchant_1 = create(:merchant)
        @merchant_2 = create(:merchant)

        @item_1 = create(:item, merchant: @merchant_1)
        @item_2 = create(:item, merchant: @merchant_2)

        @invoice_1.items << @item_1
        @invoice_2.items << @item_1
        @invoice_3.items << @item_1
        @invoice_4.items << @item_1
        @invoice_5.items << @item_1
        @invoice_6.items << @item_1
        @invoice_7.items << @item_1
        @invoice_8.items << @item_1
        @invoice_9.items << @item_1
        @invoice_10.items << @item_1
        @invoice_11.items << @item_1
        @invoice_12.items << @item_1
        @invoice_13.items << @item_1
        @invoice_14.items << @item_1
        @invoice_15.items << @item_1
        @invoice_16.items << @item_1
        @invoice_17.items << @item_1
        @invoice_18.items << @item_1
        @invoice_19.items << @item_1
        @invoice_20.items << @item_1
        @invoice_21.items << @item_1
        @invoice_22.items << @item_1
        @invoice_23.items << @item_1

        @transaction_1 = create(:transaction, invoice: @invoice_1, result: :failed)
        @transaction_2 = create(:transaction, invoice: @invoice_1, result: :success) #merch_1 cust_1
        @transaction_3 = create(:transaction, invoice: @invoice_2, result: :success) #merch_1 cust_2
        @transaction_4 = create(:transaction, invoice: @invoice_3, result: :success) #merch_1 cust_3
        @transaction_5 = create(:transaction, invoice: @invoice_4, result: :success) #merch_1 cust_4
        @transaction_6 = create(:transaction, invoice: @invoice_5, result: :success) #merch_1&2 cust_5
        @transaction_7 = create(:transaction, invoice: @invoice_6, result: :success) #mercht_1&2 cust_6
        @transaction_8 = create(:transaction, invoice: @invoice_7, result: :success) #merch_1 cust_7
        @transaction_9 = create(:transaction, invoice: @invoice_8, result: :success) #merch_1 cust_8
        @transaction_10 = create(:transaction, invoice: @invoice_9, result: :success) #merch_1 cust 5
        @transaction_11 = create(:transaction, invoice: @invoice_10, result: :success) #merch_1 cust 6
        @transaction_12 = create(:transaction, invoice: @invoice_11, result: :success) #merch_1 cust 4
        @transaction_13 = create(:transaction, invoice: @invoice_12, result: :success) #merch_1 cust 4
        @transaction_14 = create(:transaction, invoice: @invoice_13, result: :success) #merch_1 cust 4
        @transaction_15 = create(:transaction, invoice: @invoice_14, result: :success) #merch_1 cust 6
        @transaction_16 = create(:transaction, invoice: @invoice_15, result: :success) #merch_1 cust 4
        @transaction_17 = create(:transaction, invoice: @invoice_16, result: :success) #merch_1 cust 4
        @transaction_18 = create(:transaction, invoice: @invoice_17, result: :success) #merch_1 cust 5
        @transaction_19 = create(:transaction, invoice: @invoice_18, result: :success) #merch_1 cust_5
        @transaction_20 = create(:transaction, invoice: @invoice_19, result: :success) #merch_1 cust_6
        @transaction_21 = create(:transaction, invoice: @invoice_20, result: :success) #merch_1 cust_6
        @transaction_22 = create(:transaction, invoice: @invoice_21, result: :success) #merch_1 cust_7
        @transaction_23 = create(:transaction, invoice: @invoice_22, result: :success) #merch_1 cust_7
        @transaction_24 = create(:transaction, invoice: @invoice_23, result: :success) #merch_1 cust_8
      end
      it 'returns the top 5 customers by successful transactions with the merchant' do
        expect(@merchant_1.top_five_customers).to eq([@customer_4, @customer_6, @customer_5, @customer_7, @customer_8])
        expect(@merchant_1.top_five_customers[0].transaction_count).to eq(6)
        expect(@merchant_1.top_five_customers[1].transaction_count).to eq(5)
        expect(@merchant_1.top_five_customers[2].transaction_count).to eq(4)
        expect(@merchant_1.top_five_customers[3].transaction_count).to eq(3)
        expect(@merchant_1.top_five_customers[4].transaction_count).to eq(2)
      end

      it 'doesnt count failed trasnactions' do
        invoice_24 = create(:invoice, customer: @customer_6)
        invoice_25 = create(:invoice, customer: @customer_6)

        invoice_24.items << @item_1
        invoice_25.items << @item_1

        transaction_25 = create(:transaction, invoice: invoice_24, result: :failed)
        transaction_26 = create(:transaction, invoice: invoice_25, result: :failed)

        expect(@merchant_1.top_five_customers).to eq([@customer_4, @customer_6, @customer_5, @customer_7, @customer_8])
      end

      it 'doesnt count other merchant transactions' do
        merchant_2 = create(:merchant)
        item_2 = create(:item, merchant: merchant_2)

        invoice_24 = create(:invoice, customer: @customer_6)
        invoice_25 = create(:invoice, customer: @customer_6)

        invoice_24.items << item_2
        invoice_25.items << item_2

        transaction_25 = create(:transaction, invoice: invoice_24, result: :success)
        transaction_26 = create(:transaction, invoice: invoice_25, result: :success)

        expect(@merchant_1.top_five_customers).to eq([@customer_4, @customer_6, @customer_5, @customer_7, @customer_8])
      end
    end

    describe 'test instance variables for .top_five_revenue' do
      before(:each) do
        @merch1 = create(:merchant)
        @item1 = create(:item, merchant: @merch1, unit_price: 5700)
        @item2 = create(:item, merchant: @merch1)

        @merch2 = create(:merchant)
        @item3 = create(:item, merchant: @merch2, unit_price: 500)
        @item4 = create(:item, merchant: @merch2, unit_price: 500)
        @item5 = create(:item, merchant: @merch2, unit_price: 500)
        @item6 = create(:item, merchant: @merch2, unit_price: 500)
        @item7 = create(:item, merchant: @merch2, unit_price: 500)
        @item8 = create(:item, merchant: @merch2, unit_price: 500)
        @item9 = create(:item, merchant: @merch2, unit_price: 500)

        @invoice1 = create(:invoice, status: :completed)
        @invoice2 = create(:invoice, status: :completed)
        @invoice3 = create(:invoice, status: :completed)
        @invoice4 = create(:invoice, status: :completed)
        @invoice5 = create(:invoice, status: :completed)

        @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item3, quantity: 10, unit_price: 100, status: :packaged)
        @inv_item2 = create(:invoice_item, invoice: @invoice2, item: @item4, quantity: 11, unit_price: 100, status: :packaged)
        @inv_item3 = create(:invoice_item, invoice: @invoice3, item: @item5, quantity: 12, unit_price: 100, status: :packaged)
        @inv_item4 = create(:invoice_item, invoice: @invoice4, item: @item6, quantity: 13, unit_price: 100, status: :packaged)
        @inv_item5 = create(:invoice_item, invoice: @invoice5, item: @item7, quantity: 14, unit_price: 100, status: :packaged)
        @inv_item6 = create(:invoice_item, invoice: @invoice1, item: @item8, quantity: 15, unit_price: 100, status: :packaged)
        @inv_item7 = create(:invoice_item, invoice: @invoice2, item: @item9, quantity: 16, unit_price: 100, status: :packaged)
        @inv_item8 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 10, unit_price: 100, status: :packaged)
        @inv_item9 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 11, unit_price: 100, status: :packaged)
        @inv_item10 = create(:invoice_item, invoice: @invoice5, item: @item5, quantity: 12, unit_price: 100, status: :packaged)

        @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: :success)
        @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: :failed)
        @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: :success)
        @transaction4 = create(:transaction, invoice_id: @invoice4.id, result: :success)
        @transaction5 = create(:transaction, invoice_id: @invoice5.id, result: :success)
        @transaction6 = create(:transaction, invoice_id: @invoice1.id, result: :success)
        @transaction7 = create(:transaction, invoice_id: @invoice2.id, result: :failed)
        @transaction8 = create(:transaction, invoice_id: @invoice3.id, result: :failed)
        @transaction9 = create(:transaction, invoice_id: @invoice4.id, result: :failed)
        @transaction10 = create(:transaction, invoice_id: @invoice5.id, result: :failed)
      end

      it '.top_five_revenue' do
        expect(@merch2.top_five_revenue).to match_array([@item5, @item7, @item3, @item6, @item8])
        expect(@merch2.top_five_revenue).to eq([@item3, @item8, @item5, @item7, @item6])
      end
    end
    
    describe '.inv_items_ready_to_ship' do
      before :each do
        @merchant = create(:merchant)
        @items = create_list(:item, 6, merchant: @merchant)

        @invoice_1 = create(:invoice, created_at: '2012-03-25 09:54:09 UTC')
        @invoice_2 = create(:invoice, created_at: '2012-03-26 09:54:09 UTC')
        @invoice_3 = create(:invoice, created_at: '2012-03-27 09:54:09 UTC')
        @invoice_4 = create(:invoice, created_at: '2012-03-28 09:54:09 UTC')

        @inv_item_1 = create(:invoice_item, item: @items[0], invoice: @invoice_3, status: :packaged)
        @inv_item_2 = create(:invoice_item, item: @items[4], invoice: @invoice_4, status: :pending)
        @inv_item_3 = create(:invoice_item, item: @items[3], invoice: @invoice_1, status: :shipped)
        @inv_item_4 = create(:invoice_item, item: @items[1], invoice: @invoice_1, status: :packaged)
        @inv_item_5 = create(:invoice_item, item: @items[2], invoice: @invoice_1, status: :shipped)
        @inv_item_5 = create(:invoice_item, item: @items[5], invoice: @invoice_2, status: :pending)
      end

      it 'returns a list of invoice items that are not yet shipped' do
        expect(@merchant.inv_items_ready_to_ship).to match_array([@inv_item_1, @inv_item_2, @inv_item_4, @inv_item_5])
      end

      it 'lists them oldest to newest' do
        expect(@merchant.inv_items_ready_to_ship).to eq([@inv_item_4, @inv_item_5, @inv_item_1, @inv_item_2])
      end
    end
  end

  describe 'class_methods' do
    describe '#top_five_merchants' do
      it 'returns the top five merchants based on successful transactions' do
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_3 = Merchant.create!(name: 'Patrick The Starfish')
        merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
        merchant_4 = Merchant.create!(name: 'Mr. Krabs The Boss')
        merchant_5 = Merchant.create!(name: 'Barnacle Boy The Sidekick')
        merchant_6 = Merchant.create!(name: 'Mermaid Man The Hero')

        customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
        customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
        customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

        item_1 = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
        item_2 = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
        item_3 = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
        item_4 = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
        item_5 = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
        item_5 = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
        item_6 = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
        item_7 = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)
        item_8 = Item.create!(name: 'Spatula2', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_2.id)
        item_9 = Item.create!(name: 'Spoon2', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_3.id)
        item_10 = Item.create!(name: 'Knife2', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_4.id)
        item_11 = Item.create!(name: 'Computer2', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_5.id)
        item_12 = Item.create!(name: 'Table2', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_6.id)
        item_13 = Item.create!(name: 'Bag of Money2', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_6.id)
        item_14 = Item.create!(name: 'Decorative Wood 72', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_6.id)

        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', result: 'success')
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', result: 'success')
        transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', result: 'success')
        transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', result: 'success')
        transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', result: 'success')
        transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', result: 'success')
        transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', result: 'success')
        transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', result: 'failed')

        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
        invoice_item_7 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_8 = InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_9 = InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_10 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
        invoice_item_11 = InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_12 = InvoiceItem.create!(item_id: item_11.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
        invoice_item_13 = InvoiceItem.create!(item_id: item_12.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_13 = InvoiceItem.create!(item_id: item_13.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_13 = InvoiceItem.create!(item_id: item_14.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)

        expect(Merchant.top_five_merchants.first).to eq(merchant_1)
        expect(Merchant.top_five_merchants[1]).to eq(merchant_2)
        expect(Merchant.top_five_merchants[2]).to eq(merchant_3)
        expect(Merchant.top_five_merchants[3]).to eq(merchant_5)
        expect(Merchant.top_five_merchants.last).to eq(merchant_4)
      end
    end
  end
end
