require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe '#instance methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Etsy', status: 1)
      @merchant_2 = Merchant.create!(name: 'Build-a-Bear', status: 1)
      @merchant_3 = Merchant.create!(name: 'Target')
      @merchant_4 = Merchant.create!(name: 'Walmart')
      @merchant_5 = Merchant.create!(name: 'Dicks')
      @merchant_6 = Merchant.create!(name: 'Costco')
      @item_1 = @merchant_1.items.create!(name: 'Axe', description: 'Chop stuff', unit_price: 1000)
      @item_2 = @merchant_1.items.create!(name: 'Hammer', description: 'Hit stuff', unit_price: 1500)
      @item_3 = @merchant_1.items.create!(name: 'Drill', description: 'Drill stuff', unit_price: 5000)
      @item_4 = @merchant_2.items.create!(name: 'Wrench', description: 'Turn stuff', unit_price: 900)
      @item_5 = @merchant_2.items.create!(name: 'Flashlight', description: 'Shine stuff', unit_price: 1550)
      @item_6 = @merchant_1.items.create!(name: 'Shovel', description: 'Dig stuff', unit_price: 2550)
      @item_7 = @merchant_1.items.create!(name: 'Helmet', description: 'Head stuff', unit_price: 3550)
      @item_8 = @merchant_1.items.create!(name: 'Nail Gun', description: 'Nail stuff', unit_price: 4550)
      @item_9 = @merchant_1.items.create!(name: 'Saw', description: 'Saw stuff', unit_price: 5550)
      @item_10 = @merchant_3.items.create!(name: 'Hacksaw', description: 'Saw stuff', unit_price: 2050)
      @item_11 = @merchant_4.items.create!(name: 'Bolt Cutters', description: 'Cut stuff', unit_price: 3800)
      @item_12 = @merchant_5.items.create!(name: 'Gloves', description: 'Hand stuff', unit_price: 750)
      @item_13 = @merchant_6.items.create!(name: 'Boots', description: 'Foot stuff', unit_price: 5550)
      @customer_1 = Customer.create!(first_name: 'Jon', last_name: 'Jones')
      @customer_2 = Customer.create!(first_name: 'Jan', last_name: 'Jones')
      @customer_3 = Customer.create!(first_name: 'Jin', last_name: 'Jones')
      @customer_4 = Customer.create!(first_name: 'Joon', last_name: 'Jones')
      @customer_5 = Customer.create!(first_name: 'Joc', last_name: 'Jones')
      @customer_6 = Customer.create!(first_name: 'JakJak', last_name: 'Jones')
      @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09 UTC')
      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_2 = @customer_2.invoices.create!(status: 1, created_at: '2012-03-26')
      @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_3 = @customer_2.invoices.create!(status: 1, created_at: '2012-03-27')
      @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_4 = @customer_3.invoices.create!(status: 1, created_at: '2012-03-28')
      @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_5 = @customer_3.invoices.create!(status: 1, created_at: '2012-03-29')
      @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_6 = @customer_6.invoices.create!(status: 1, created_at: '2012-03-30')
      @transaction_6 = @invoice_6.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_7 = @customer_5.invoices.create!(status: 1, created_at: '2012-03-31')
      @transaction_7 = @invoice_7.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_8 = @customer_4.invoices.create!(status: 1, created_at: '2012-04-01')
      @transaction_8 = @invoice_8.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_9 = @customer_4.invoices.create!(status: 1, created_at:'2012-04-02')
      @transaction_9 = @invoice_9.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_10 = @customer_5.invoices.create!(status: 1, created_at: '2012-04-03')
      @transaction_10 = @invoice_10.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_11 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_11 = @invoice_11.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_12 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_12 = @invoice_12.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_13 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_13 = @invoice_13.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_14 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_14 = @invoice_14.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_15 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_15 = @invoice_15.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_16 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_16 = @invoice_16.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_17 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_17 = @invoice_17.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_18 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_18 = @invoice_18.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_19 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_19 = @invoice_19.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_20 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_20 = @invoice_20.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_21 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
      @transaction_21 = @invoice_21.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id) 
      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id) 
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id) 
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_4.id) 
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_5.id) 
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_6.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_7.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_8.id) 
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_9.id) 
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_10.id) 
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_11.id) 
      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_11.id) 
      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_10.id) 
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_9.id) 
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_8.id) 
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_7.id) 
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_6.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_5.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id) 
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_3.id) 
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_2.id) 
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_1.id) 
      InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_12.id) 
      InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_13.id) 
      InvoiceItem.create!(item_id: @item_8.id, invoice_id: @invoice_14.id) 
      InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_15.id) 
      InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_16.id) 
      InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_17.id) 
      InvoiceItem.create!(item_id: @item_10.id, invoice_id: @invoice_18.id) 
      InvoiceItem.create!(item_id: @item_11.id, invoice_id: @invoice_19.id) 
      InvoiceItem.create!(item_id: @item_12.id, invoice_id: @invoice_20.id) 
      InvoiceItem.create!(item_id: @item_13.id, invoice_id: @invoice_21.id) 
    end

    it "returns the top 5 customers with most transactions for a merchant" do
      expect(@merchant_1.top_5_customers).to eq([@customer_6, @customer_2, @customer_3, @customer_4, @customer_5])
      expect(@merchant_1.top_5_customers).to_not eq([@customer_1])
      expect(@merchant_2.top_5_customers).to eq([@customer_6, @customer_2, @customer_3, @customer_4, @customer_5])
    end

    it 'reutrns the top 5 items for a merchant' do
      expect(@merchant_1.top_5_items).to eq([@item_3, @item_9, @item_2, @item_8, @item_1])
    end

    it 'can update merchant status' do
      @merchant_1 = Merchant.create!(name: 'Etsy')

      @merchant_1.status_update(1)
      expect(@merchant_1.status).to eq('enabled')
    end

    it 'can sort by status' do
      expect(Merchant.enabled_merchants).to eq([@merchant_1, @merchant_2])
      expect(Merchant.disabled_merchants).to eq([@merchant_3, @merchant_4, @merchant_5, @merchant_6])
    end

    it 'can list top 5 merchants' do
      expect(Merchant.top_5_merchants).to eq([@merchant_1, @merchant_2, @merchant_6, @merchant_4, @merchant_3])
    end
  end
end