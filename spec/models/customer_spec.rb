require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "instance methods" do
    it 'can return full name' do
      @customer00 = Customer.create!(first_name: 'Will', last_name: 'Rogers')
      @customer01 = Customer.create!(first_name: 'Carl', last_name: 'Weathers')
      
      expect(@customer00.full_name).to eq('Will Rogers')
      expect(@customer01.full_name).to eq('Carl Weathers')
    end
  end

  describe "class methods" do
    it 'can list top 5 customers across all merchants' do
      @merchant_1 = Merchant.create!(name: 'Etsy')
      @merchant_2 = Merchant.create!(name: 'Build-a-Bear')
      @item_1 = @merchant_1.items.create!(name: 'Axe', description: 'Chop stuff', unit_price: 1000)
      @item_2 = @merchant_1.items.create!(name: 'Hammer', description: 'Hit stuff', unit_price: 1500)
      @item_3 = @merchant_1.items.create!(name: 'Drill', description: 'Drill stuff', unit_price: 5000)
      @item_4 = @merchant_2.items.create!(name: 'Wrench', description: 'Turn stuff', unit_price: 900)
      @item_5 = @merchant_2.items.create!(name: 'Nail', description: 'Nail stuff', unit_price: 50)
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
      @invoice_12 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09 UTC')
      @transaction_12 = @invoice_12.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_13 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09 UTC')
      @transaction_13 = @invoice_13.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_14 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09 UTC')
      @transaction_14 = @invoice_14.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_15 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09 UTC')
      @transaction_15 = @invoice_15.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_16 = @customer_4.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09 UTC')
      @transaction_16 = @invoice_16.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_17 = @customer_4.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09 UTC')
      @transaction_17 = @invoice_17.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
      @invoice_18 = @customer_2.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09 UTC')
      @transaction_18 = @invoice_18.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
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
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_12.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_13.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_14.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_15.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_16.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_17.id) 
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_18.id) 

      expect(Customer.top_customers).to eq([@customer_1, @customer_4, @customer_2, @customer_3, @customer_5])
    end
  end
end