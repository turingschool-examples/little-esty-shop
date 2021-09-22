require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'top 5 customers per merchant' do
    before :each do

      @merchant_1 = Merchant.create!(name: "Cool Shirts")
      @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)

      # Customer 1 has 2 successful transactions
      @customer_1 = Customer.create!(first_name: 'Bob', last_name: 'Johnson')
      @invoice_1 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_1 = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_2 = @invoice_1.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
      @transaction_1 = @invoice_1.transactions.create!(result: "success")
      @invoice_2 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
      @invoice_item_3 = @invoice_2.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_4 = @invoice_2.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
      @transaction_1 = @invoice_2.transactions.create!(result: "success")

      # Customer 2 has 1 succesful transaction
      @customer_2 = Customer.create!(first_name: 'Josh', last_name: 'Johnson')
      @invoice_3 = @customer_2.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_5 = @invoice_3.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_6 = @invoice_3.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
      @transaction_2 = @invoice_3.transactions.create!(result: "success")
      
      # Customer 3 has 1 successful transaction and 1 failure the failure is to test that it counts only successful transactions
      @customer_3 = Customer.create!(first_name: 'Micheal', last_name: 'Johnson')
      @invoice_4 = @customer_3.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_7 = @invoice_4.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_8 = @invoice_4.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
      @transaction_3 = @invoice_4.transactions.create!(result: "failed")
      @transaction_4 = @invoice_4.transactions.create!(result: "success")

      # Customer 4 has 3 successful transactions
      @customer_4 = Customer.create!(first_name: 'Magic', last_name: 'Johnson')
      @invoice_5 = @customer_4.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_9 = @invoice_5.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_10 = @invoice_5.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
      @transaction_5 = @invoice_5.transactions.create!(result: "success")
      @invoice_6 = @customer_4.invoices.create!(status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
      @invoice_item_11 = @invoice_6.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_12 = @invoice_6.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
      @transaction_6 = @invoice_6.transactions.create!(result: "success")
      @invoice_7 = @customer_4.invoices.create!(status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
      @invoice_item_13 = @invoice_7.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_14 = @invoice_7.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
      @transaction_7 = @invoice_7.transactions.create!(result: "success")

      # Customer 5 has no sucessful transactions

      @customer_5 = Customer.create!(first_name: 'Massive', last_name: 'Johnson')
      @invoice_8 = @customer_5.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_15 = @invoice_8.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_16 = @invoice_8.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
      @transaction_8 = @invoice_8.transactions.create!(result: "failed")

      @customer_6 = Customer.create!(first_name: 'Major', last_name: 'Johnson')
      @invoice_9 = @customer_6.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_15 = @invoice_9.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_16 = @invoice_9.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
      @transaction_9 = @invoice_9.transactions.create!(result: "success")

      # To ensure that it picks from the correct merchant
      @merchant_2 = Merchant.create!(name: "Ugly Shirts")
      @item_2 = Item.create!(name: "Old shirt", description: "less ugly shirt", unit_price: 1000, merchant_id: @merchant_2.id)
    end

    it 'returns 5 best customers inorder of most transactions' do 
      
      expect(@merchant_1.top_5_customers).to eq([@customer_4, @customer_1, @customer_2, @customer_3, @customer_6])
    end
  end

  describe 'top items per merchant' do
    before :each do 
      @merchant_1 = Merchant.create!(name: "Cool Shirts")

      # Item 1 produced 2400 revenue
      @item_1 = @merchant_1.items.create!(name: "Dog", description: "Dog shirt", unit_price: 1400)
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @invoice_1 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_1a = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_1b = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1000, status: "packaged")
      @transaction_1 = @invoice_1.transactions.create!(result: "success")

      # Item 2 produced 5400 revenue the quantity of invoice_item_2b is 4 to demonstrate the revenue calculation
      @item_2 = @merchant_1.items.create!(name: "burger", description: "burger shirt", unit_price: 1400)
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @invoice_2 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_2a = @invoice_2.invoice_items.create!(item: @item_2, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_2b = @invoice_2.invoice_items.create!(item: @item_2, quantity: 4, unit_price: 1000, status: "packaged")
      @transaction_2 = @invoice_2.transactions.create!(result: "success")

      # Item 3 produced 4000 revenue. Transaction 3 failed but because there is a success for invoice 3 it will be counted towards total revenue
      @item_3 = @merchant_1.items.create!(name: "Omg", description: "Omg shirt", unit_price: 1400)
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @invoice_3 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_3a = @invoice_3.invoice_items.create!(item: @item_3, quantity: 2, unit_price: 1000, status: "pending")
      @invoice_item_3b = @invoice_3.invoice_items.create!(item: @item_3, quantity: 2, unit_price: 1000, status: "packaged")
      @transaction_3 = @invoice_3.transactions.create!(result: "failed")
      @transaction_4 = @invoice_3.transactions.create!(result: "success")

      # Item 4 produced 6000 revenue. This set is ment to demonstrate that multiple invoices will be counted towards the item revenue
      @item_4 = @merchant_1.items.create!(name: "suck", description: "suck shirt", unit_price: 1400)
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @invoice_4 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_4a = @invoice_4.invoice_items.create!(item: @item_4, quantity: 2, unit_price: 1000, status: "pending")
      @invoice_item_4b = @invoice_4.invoice_items.create!(item: @item_4, quantity: 2, unit_price: 1000, status: "packaged")
      @transaction_5 = @invoice_4.transactions.create!(result: "success")
      @invoice_5 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_5a = @invoice_5.invoice_items.create!(item: @item_4, quantity: 1, unit_price: 1000, status: "pending")
      @invoice_item_5b = @invoice_5.invoice_items.create!(item: @item_4, quantity: 1, unit_price: 1000, status: "packaged")
      @transaction_6 = @invoice_5.transactions.create!(result: "success")

      # Item 5 produced 2000 revenue. The set is to demonstrate that if the trasaction failed for that invoice then it will not count towards the item revenue
      @item_5 = @merchant_1.items.create!(name: "gobble", description: "turkey shirt", unit_price: 1400)
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @invoice_6 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_6a = @invoice_6.invoice_items.create!(item: @item_5, quantity: 2, unit_price: 1000, status: "pending")
      @invoice_item_6b = @invoice_6.invoice_items.create!(item: @item_5, quantity: 2, unit_price: 1000, status: "packaged")
      @transaction_7 = @invoice_6.transactions.create!(result: "failed")
      @invoice_7 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_7a = @invoice_7.invoice_items.create!(item: @item_5, quantity: 1, unit_price: 1000, status: "pending")
      @invoice_item_7b = @invoice_7.invoice_items.create!(item: @item_5, quantity: 1, unit_price: 1000, status: "packaged")
      @transaction_8 = @invoice_7.transactions.create!(result: "success")
    end

    it 'returns the most popular items by revenue generated' do
      expect(@merchant_1.top_5_items).to eq([@item_4, @item_2, @item_3, @item_1, @item_5])
    end
  end

  describe 'class methods' do
    before :each do
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @customer_2 = Customer.create(first_name: 'Sally', last_name: 'Johnson')
      @customer_3 = Customer.create(first_name: 'Bill', last_name: 'Smith')
      @customer_4 = Customer.create(first_name: 'Sara', last_name: 'Smith')
      @customer_5 = Customer.create(first_name: 'Santa', last_name: 'Claus')
      @customer_6 = Customer.create(first_name: 'Barry', last_name: 'Jones')
      @merchant_1 = Merchant.create!(name: "Cool Shirts")
      @merchant_2 = Merchant.create!(name: "Ugly Shirts", status: 1)
      @merchant_3 = Merchant.create!(name: "Rad Shirts")
      @merchant_4 = Merchant.create!(name: "Bad Shirts", status: 1)
      @merchant_5 = Merchant.create!(name: "Khoi's Shirts")
      @merchant_6 = Merchant.create!(name: "Kelsey's Shirts")
      @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: "Old shirt", description: "less ugly shirt", unit_price: 1000, merchant_id: @merchant_2.id)
      @item_3 = Item.create!(name: "cool shirt", description: "super cool shirt", unit_price: 1700, merchant_id: @merchant_3.id)
      @item_4 = Item.create!(name: "shirt with kitten", description: "super cool shirt", unit_price: 700, merchant_id: @merchant_4.id)
      @item_5 = Item.create!(name: "black shirt", description: "super cool shirt", unit_price: 1600, merchant_id: @merchant_5.id)
      @item_6 = Item.create!(name: "shirt with flowers", description: "super cool shirt", unit_price: 1300, merchant_id: @merchant_6.id)
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
      @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2010-03-12 09:50:09 UTC")
      @invoice_4 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2017-03-12 06:50:09 UTC")
      @invoice_5 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2009-03-12 09:50:09 UTC")
      @invoice_6 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
      @invoice_7 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
      @invoice_8 = Invoice.create(customer_id: @customer_2.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
      @invoice_9 = Invoice.create(customer_id: @customer_3.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
      @invoice_10 = Invoice.create(customer_id: @customer_3.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
      @invoice_12 = Invoice.create(customer_id: @customer_4.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
      @invoice_11 = Invoice.create(customer_id: @customer_5.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
      @invoice_13 = Invoice.create(customer_id: @customer_5.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
      @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 1, unit_price: 1000, status: "packaged")
      @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, quantity: 1, unit_price: 1700, status: "shipped")
      @invoice_item_4 = InvoiceItem.create!(item: @item_4, invoice: @invoice_4, quantity: 1, unit_price: 700, status: "shipped")
      @invoice_item_5 = InvoiceItem.create!(item: @item_5, invoice: @invoice_5, quantity: 1, unit_price: 1600, status: "shipped")
      @invoice_item_6 = InvoiceItem.create!(item: @item_6, invoice: @invoice_6, quantity: 1, unit_price: 1300, status: "shipped")
      @invoice_item_7 = InvoiceItem.create!(item: @item_1, invoice: @invoice_7, quantity: 2, unit_price: 1400, status: "shipped")
      @invoice_item_8 = InvoiceItem.create!(item: @item_1, invoice: @invoice_8, quantity: 2, unit_price: 1400, status: "shipped")
      @invoice_item_9 = InvoiceItem.create!(item: @item_1, invoice: @invoice_9, quantity: 2, unit_price: 1400, status: "shipped")
      @invoice_item_10 = InvoiceItem.create!(item: @item_1, invoice: @invoice_10, quantity: 2, unit_price: 1400, status: "shipped")
      @invoice_item_11 = InvoiceItem.create!(item: @item_1, invoice: @invoice_11, quantity: 2, unit_price: 1400, status: "shipped")
      @invoice_item_12 = InvoiceItem.create!(item: @item_1, invoice: @invoice_12, quantity: 2, unit_price: 1400, status: "shipped")
      @invoice_item_13 = InvoiceItem.create!(item: @item_1, invoice: @invoice_13, quantity: 2, unit_price: 1400, status: "shipped")
      Transaction.create!(invoice_id: @invoice_1.id, result: "success")
      Transaction.create!(invoice_id: @invoice_2.id, result: "success")
      Transaction.create!(invoice_id: @invoice_3.id, result: "success")
      Transaction.create!(invoice_id: @invoice_4.id, result: "success")
      Transaction.create!(invoice_id: @invoice_5.id, result: "success")
      Transaction.create!(invoice_id: @invoice_6.id, result: "success")
      Transaction.create!(invoice_id: @invoice_8.id, result: "success")
      Transaction.create!(invoice_id: @invoice_10.id, result: "success")
      Transaction.create!(invoice_id: @invoice_11.id, result: "success")
      Transaction.create!(invoice_id: @invoice_12.id, result: "success")
      Transaction.create!(invoice_id: @invoice_9.id, result: "success")
      Transaction.create!(invoice_id: @invoice_13.id, result: "success")

    end

    describe 'class methods' do
      it 'returns the top 5 merchants based on revenue' do

        expect(Merchant.top_5_merchants).to eq([@merchant_3, @merchant_5, @merchant_1, @merchant_6, @merchant_2])
      end
      it 'returns a list of all enabled merchants' do
        expect(Merchant.enabled_list).to eq([@merchant_1,@merchant_3, @merchant_5, @merchant_6 ])
      end

      it 'returns a list of all enabled merchants' do
        expect(Merchant.disabled_list).to eq([@merchant_2, @merchant_4])
      end
    end

    describe 'instance methods' do
      it 'returns the best day of revenue for a specific merchant' do
        expect(@merchant_1.merchant_best_day_ever).to eq(@invoice_7.created_at.strftime("%m/%d/%y"))
      end
    end
  end 
end
