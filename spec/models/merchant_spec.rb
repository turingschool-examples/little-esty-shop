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
      @merchant_1 = Merchant.create!(name: 'Etsy')
      @merchant_2 = Merchant.create!(name: 'Walmart')
      @item_1 = @merchant_1.items.create!(name: 'Axe', description: 'Chop stuff', unit_price: 1000)
      @item_2 = @merchant_1.items.create!(name: 'Hammer', description: 'Hit stuff', unit_price: 1500)
      @item_3 = @merchant_1.items.create!(name: 'Drill', description: 'Drill stuff', unit_price: 5000)
      @item_4 = @merchant_1.items.create!(name: 'Wrench', description: 'Turn stuff', unit_price: 900)
      @item_5 = @merchant_1.items.create!(name: 'Nail', description: 'Nail stuff', unit_price: 50)
      @item_6 = @merchant_2.items.create!(name: 'Nail', description: 'Nail stuff', unit_price: 5000)
      @customer_6 = Customer.create!(first_name: 'JakJak', last_name: 'Jones')
      @customer_1 = Customer.create!(first_name: 'Jon', last_name: 'Jones')
      @customer_2 = Customer.create!(first_name: 'Jan', last_name: 'Jones')
      @customer_3 = Customer.create!(first_name: 'Jin', last_name: 'Jones')
      @customer_4 = Customer.create!(first_name: 'Joon', last_name: 'Jones')
      @customer_5 = Customer.create!(first_name: 'Joc', last_name: 'Jones')
      @customer_6 = Customer.create!(first_name: 'Evil', last_name: 'Genius')
      @invoice_1 = @customer_1.invoices.create!(status: 'completed')
      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      @invoice_2 = @customer_2.invoices.create!(status: 'completed')
      @transaction_2 = @invoice_2.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      @invoice_3 = @customer_3.invoices.create!(status: 'completed')
      @transaction_3 = @invoice_3.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      @invoice_4 = @customer_4.invoices.create!(status: 'completed')
      @transaction_4 = @invoice_4.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      @invoice_5 = @customer_5.invoices.create!(status: 'completed')
      @transaction_5 = @invoice_5.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      @invoice_6 = @customer_6.invoices.create!(status: 'completed')
      @transaction_6 = @invoice_6.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      @invoice_7 = @customer_6.invoices.create!(status: 'completed')
      @transaction_7 = @invoice_7.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      @invoice_8 = @customer_6.invoices.create!(status: 'completed')
      @transaction_8 = @invoice_8.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      @invoice_9 = @customer_6.invoices.create!(status: 'completed')
      @transaction_9 = @invoice_9.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      @invoice_10 = @customer_6.invoices.create!(status: 'completed')
      @transaction_10 = @invoice_10.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      @invoice_11 = @customer_6.invoices.create!(status: 'completed')
      @transaction_11 = @invoice_11.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id) 
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id) 
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id) 
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id)
      InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_6.id)
      InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_7.id)
      InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_8.id)
      InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_9.id)
      InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_10.id)
      InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_11.id)
    end

    it "returns the top 5 customers with most transactions for a merchant" do
      expect(@merchant_1.top_5_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      expect(@merchant_1.top_5_customers).to_not eq([@customer_6])
      expect(@merchant_2.top_5_customers).to eq([@customer_6])
    end

    it 'reutrns the top 5 items for a merchant' do
      expect(@merchant_1.top_5_items).to eq([@item_3, @item_2, @item_1, @item_4, @item_5])
    end

    it 'can update merchant status' do
      @merchant_1 = Merchant.create!(name: 'Etsy')

      @merchant_1.status_update(1)
      expect(@merchant_1.status).to eq('enabled')
    end
  end
end