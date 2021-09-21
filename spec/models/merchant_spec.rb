require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items)}
    it { should have_many(:customers).through(:invoices)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'enable/disable item button' do
    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @customer_1 = create(:customer)
      @item_1 = create(:item, merchant: @merchant_1, status: 0)
      @item_2 = create(:item, merchant: @merchant_1, status: 1)
    end

    it 'can get enabled items' do
      expect(@merchant_1.enabled).to eq([@item_2])
    end

    it 'can get disabled items' do
      expect(@merchant_1.disabled).to eq([@item_1])
    end
  end

  describe 'class methods' do
    it 'can fetch enabled merchants' do
      merchant_1 = create(:merchant, status: true)
      merchant_2 = create(:merchant, status: false)

      expect(Merchant.enabled_merchants).to eq([merchant_1])
    end

    it 'can fetch disabled merchants' do
      merchant_1 = create(:merchant, status: true)
      merchant_2 = create(:merchant, status: false)

      expect(Merchant.disabled_merchants).to eq([merchant_2])
    end
  end

  describe 'Merchant dashboard page' do
    before(:each) do
      @customer = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer, created_at: "Friday, September 17, 2021" )
      @invoice_2 = create(:invoice, customer: @customer, created_at: "Thursday, September 16, 2021")
      @invoice_3 = create(:invoice, customer: @customer, created_at: "Wednesday, September 15, 2021")
      @invoice_4 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @merchant = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant, name: "a")
      @item_2 = create(:item, merchant: @merchant, name: "b")
      @item_3 = create(:item, merchant: @merchant_2, name: "c")
      @invoice_item_1 = create(:invoice_item, item: @item_3, status: 0, invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, item: @item_2, status: 0,invoice: @invoice_2, created_at: "Thursday, September 16, 2021")
      @invoice_item_3 = create(:invoice_item, item: @item_1, status: 1, invoice: @invoice_3, created_at: "Wednesday, September 15, 2021")
      @invoice_item_3 = create(:invoice_item, item: @item_3, status: 0, invoice: @invoice_4, created_at: "Wednesday, September 15, 2021")
    end

    it 'gets only packaged/pending items' do
      #added .sort here because I assume order doesn't matter
      expect(@merchant.packaged_items.sort).to eq([@item_2, @item_1].sort)
    end
  end

  describe 'Merchant can find 5 best customers' do
    it 'can find 5 best customers' do
      customer_1 = Customer.create!(first_name: 'Weston', last_name: 'Ellis')
      customer_2 = Customer.create!(first_name: 'Larry', last_name: 'Davit')
      customer_3 = Customer.create!(first_name: 'Billy', last_name: 'Eylish')
      customer_4 = Customer.create!(first_name: 'Harry', last_name: 'Langnif')
      customer_5 = Customer.create!(first_name: 'Bill', last_name: 'Barry')
      customer_6 = Customer.create!(first_name: 'Ted', last_name: 'Staros')
      customer_7 = Customer.create!(first_name: 'JJ', last_name: 'I dont know her last name')

      invoice_1 = customer_1.invoices.create!(status: 2)
      invoice_2 = customer_2.invoices.create!(status: 2)
      invoice_3 = customer_3.invoices.create!(status: 2)
      invoice_4 = customer_4.invoices.create!(status: 2)
      invoice_5 = customer_5.invoices.create!(status: 2)
      invoice_6 = customer_6.invoices.create!(status: 2)

      transaction_1 = invoice_1.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_1 = invoice_1.transactions.create!(credit_card_number: 123, result: 'success')

      transaction_2 = invoice_2.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_2 = invoice_2.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_2 = invoice_2.transactions.create!(credit_card_number: 123, result: 'success')

      transaction_3 = invoice_3.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_3 = invoice_3.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_3 = invoice_3.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_3 = invoice_3.transactions.create!(credit_card_number: 123, result: 'success')

      transaction_4 = invoice_4.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_4 = invoice_4.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_4 = invoice_4.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_4 = invoice_4.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_4 = invoice_4.transactions.create!(credit_card_number: 123, result: 'success')

      transaction_5 = invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_5 = invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_5 = invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_5 = invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_5 = invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_5 = invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      #tests for failed/success
      transaction_6 = invoice_6.transactions.create!(credit_card_number: 123, result: 'failed')
      transaction_7 = invoice_6.transactions.create!(credit_card_number: 123, result: 'failed')
      transaction_8 = invoice_6.transactions.create!(credit_card_number: 123, result: 'failed')
      #tests for limit
      transaction_9 = invoice_6.transactions.create!(credit_card_number: 123, result: 'success')

      merchant =  Merchant.create!(name: "Bob's Best")

      item = merchant.items.create!(name: 'coffee', description: 'iz cool', unit_price: 5000)

      InvoiceItem.create!(item: item, invoice: invoice_1, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_2, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_3, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_4, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_5, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_6, quantity: 100, unit_price: 100, status: 2)

      expect(merchant.five_best_customers).to eq([customer_5, customer_4, customer_3, customer_2, customer_1])
    end
  end

  describe 'popular items' do
    it "can list the 5 most popular items" do
      customer = create(:customer)

      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: 'A')
      item_2 = create(:item, merchant: merchant, name: 'B')
      item_3 = create(:item, merchant: merchant, name: 'C')
      item_4 = create(:item, merchant: merchant, name: 'D')
      item_5 = create(:item, merchant: merchant, name: 'E')
      item_6 = create(:item, merchant: merchant, name: 'F')
      item_7 = create(:item, merchant: merchant, name: 'G')
      item_8 = create(:item, merchant: merchant, name: 'H')
      item_9 = create(:item, merchant: merchant, name: 'I')

      invoice_1 = create(:invoice, customer: customer, created_at: "Friday, September 17, 2021" )
      transaction = create(:transaction, result: 'success', invoice: invoice_1)
      invoice_item_1 = create(:invoice_item, item: item_1, status: 2, unit_price: 2, quantity: 2, invoice: invoice_1)

      invoice_2 = create(:invoice, customer: customer, created_at: "Thursday, September 16, 2021")
      transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)
      invoice_item_2 = create(:invoice_item, item: item_2, status: 0, unit_price: 2, quantity: 3, invoice: invoice_2, created_at: "Wednesday, September 15, 2021")

      invoice_3 = create(:invoice, customer: customer, created_at: "Wednesday, September 15, 2021")
      transaction_3 = create(:transaction, result: 'success', invoice: invoice_3)
      invoice_item_3 = create(:invoice_item, item: item_3, status: 2, unit_price: 2, quantity: 4, invoice: invoice_3)

      invoice_4 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_4 = create(:transaction, result: 'success', invoice: invoice_4)
      invoice_item_4 = create(:invoice_item, item: item_4, status: 2, unit_price: 2, quantity: 5, invoice: invoice_4)

      invoice_5 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_5 = create(:transaction, result: 'success', invoice: invoice_5)
      invoice_item_5 = create(:invoice_item, item: item_5, status: 2, unit_price: 2, quantity: 6, invoice: invoice_5)

      invoice_6 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_6 = create(:transaction, result: 'failed', invoice: invoice_6)
      invoice_item_6 = create(:invoice_item, item: item_6, status: 2, unit_price: 100, quantity: 200, invoice: invoice_6)

      invoice_7 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_7 = create(:transaction, result: 'failed', invoice: invoice_7)
      invoice_item_7 = create(:invoice_item, item: item_7, status: 2, unit_price: 0, quantity: 0, invoice: invoice_7)

      expect(merchant.top_five_items).to eq([item_5, item_4, item_3, item_2, item_1])
    end
  end

  describe 'merchan† revenue information' do
    before(:each) do
      @customer = create(:customer)

      @merchant = create(:merchant)
      @item_1 = create(:item, merchant: @merchant)
      @invoice_1 = create(:invoice, customer: @customer, created_at: "Friday, September 17, 2021" )
      @transaction = create(:transaction, result: 'success', invoice: @invoice_1)
      @invoice_item_1 = create(:invoice_item, item: @item_1, status: 2, unit_price: 4, quantity: 4, invoice: @invoice_1)

      @merchant_2 = create(:merchant)
      @item_2 = create(:item, merchant: @merchant_2)
      @invoice_2 = create(:invoice, customer: @customer, created_at: "Thursday, September 16, 2021")
      @transaction_2 = create(:transaction, result: 'success', invoice: @invoice_2)
      @invoice_item_2 = create(:invoice_item, item: @item_2, status: 0, unit_price: 6, quantity: 6, invoice: @invoice_2, created_at: "Wednesday, September 15, 2021")

      @merchant_3 = create(:merchant)
      @item_3 = create(:item, merchant: @merchant_3)
      @invoice_3 = create(:invoice, customer: @customer, created_at: "Wednesday, September 15, 2021")
      @transaction_3 = create(:transaction, result: 'success', invoice: @invoice_3)
      @invoice_item_3 = create(:invoice_item, item: @item_3, status: 2, unit_price: 8, quantity: 8, invoice: @invoice_3)

      @merchant_4 = create(:merchant)
      @item_4 = create(:item, merchant: @merchant_4)
      @invoice_4 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_4 = create(:transaction, result: 'success', invoice: @invoice_4)
      @invoice_item_4 = create(:invoice_item, item: @item_4, status: 2, unit_price: 10, quantity: 10, invoice: @invoice_4)

      @merchant_5 = create(:merchant)
      @item_5 = create(:item, merchant: @merchant_5)
      @invoice_5 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_5 = create(:transaction, result: 'success', invoice: @invoice_5)
      @invoice_item_5 = create(:invoice_item, item: @item_5, status: 2, unit_price: 12, quantity: 12, invoice: @invoice_5)

      @merchant_6 = create(:merchant)
      @item_6 = create(:item, merchant: @merchant_6)
      @invoice_6 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_6 = create(:transaction, result: 'success', invoice: @invoice_6)
      @invoice_item_6 = create(:invoice_item, item: @item_6, status: 2, unit_price: 14, quantity: 14, invoice: @invoice_6)

      @merchant_7 = create(:merchant)
      @item_7 = create(:item, merchant: @merchant_7)
      @invoice_7 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_7 = create(:transaction, result: 'failed', invoice: @invoice_7)
      @invoice_item_7 = create(:invoice_item, item: @item_7, status: 2, unit_price: 50, quantity: 50, invoice: @invoice_7)

    end
    it 'fetch best merchants' do
      expect(Merchant.five_best_merchants).to eq([@merchant_6, @merchant_5, @merchant_4, @merchant_3, @merchant_2])
    end

    it 'can calculate total revenue' do
      expect(@merchant.total_revenue).to eq(16)
      expect(@merchant_2.total_revenue).to eq(36)
      expect(@merchant_7.total_revenue).to eq(0)
    end
  end
end
