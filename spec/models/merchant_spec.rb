require "rails_helper"

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')
    @merchant_2 = Merchant.create!(name: 'Mom and pop')
    @merchant_3 = Merchant.create!(name: 'Scammers R Us', status: 1)

    @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'One description', unit_price: 10)
    @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 20)
    @item_3 = @merchant_2.items.create!(name: 'Item 3', description: 'Three Description', unit_price: 30)
    @item_4 = @merchant_1.items.create!(name: 'Item 4', description: 'Four Description', unit_price: 20)
    @item_5 = @merchant_1.items.create!(name: 'Item 5', description: 'Five Description', unit_price: 30)
    @item_6 = @merchant_1.items.create!(name: 'Item 6', description: 'Six Description', unit_price: 20)

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer_2 = Customer.create!(first_name: "Steve", last_name: "Smith")
    @customer_3 = Customer.create!(first_name: "Jill", last_name: "Biden")
    @customer_4 = Customer.create!(first_name: "Adriana", last_name: "Green")
    @customer_5 = Customer.create!(first_name: "Sally", last_name: "May")
    @customer_6 = Customer.create!(first_name: "Jo", last_name: "Shmoe")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "completed", created_at: "1991-03-23 21:40:46")
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: "cancelled", created_at: "1992-01-28 21:40:46")
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: "completed", created_at: "1993-01-28 21:40:46")
    @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: "completed", created_at: "1994-01-28 21:40:46")
    @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: "completed", created_at: "1995-01-28 21:40:46")
    @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: "cancelled", created_at: "2021-01-28 21:40:46")
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: "completed", created_at: "2021-01-28 21:40:46")

    @invoice_items_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, status: "packaged")
    @invoice_items_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, status: "shipped")
    @invoice_items_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, status: "packaged")
    @invoice_items_4 = InvoiceItem.create!(item: @item_4, invoice: @invoice_4, status: "pending")
    @invoice_items_5 = InvoiceItem.create!(item: @item_5, invoice: @invoice_5, status: "shipped")
    @invoice_items_6 = InvoiceItem.create!(item: @item_6, invoice: @invoice_6, status: "packaged")
    @invoice_items_7 = InvoiceItem.create!(item: @item_1, invoice: @invoice_7, status: "packaged")

    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000000000, cc_expiration_date: '2000-01-01 00:00:00 -0500', result: true)
    @transaction_02 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000001111, cc_expiration_date: '2001-01-01 00:00:00 -0500', result: true)
    @transaction_03 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000002222, cc_expiration_date: '2002-01-01 00:00:00 -0500', result: true)
    @transaction_04 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_05 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: false)
    @transaction_06 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2005-01-01 00:00:00 -0500', result: true)
    @transaction_08 = Transaction.create!(invoice_id: @invoice_4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_09 = Transaction.create!(invoice_id: @invoice_5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_10 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_11 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_12 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_13 = Transaction.create!(invoice_id: @invoice_5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_14 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_15 = Transaction.create!(invoice_id: @invoice_5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_16 = Transaction.create!(invoice_id: @invoice_4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_17 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_18 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: false)
    @transaction_19 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_20 = Transaction.create!(invoice_id: @invoice_4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: false)
    @transaction_21 = Transaction.create!(invoice_id: @invoice_5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_22 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: false)
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "validations" do
    it 'Merchant can be enabled' do
      expect(@merchant_1.status).to eq("enabled")
      expect(@merchant_1.enabled?).to eq(true)
      expect(@merchant_1.disabled?).to eq(false)
    end

    it 'Merchant can be disabled' do
      expect(@merchant_3.status).to eq("disabled")
      expect(@merchant_3.enabled?).to eq(false)
      expect(@merchant_3.disabled?).to eq(true)
    end
  end

  describe "instance methods" do
    it "#top_five_customer" do
      expect(@merchant_1.top_five_customers[0].first_name).to eq("Bob")
      expect(@merchant_1.top_five_customers[0].purchases).to eq(6)

      expect(@merchant_1.top_five_customers[1].first_name).to eq("Sally")
      expect(@merchant_1.top_five_customers[1].purchases).to eq(4)

      expect(@merchant_1.top_five_customers[3].first_name).to eq("Steve")
      expect(@merchant_1.top_five_customers[3].purchases).to eq(1)

      expect(@merchant_1.top_five_customers[4].nil?).to eq(false)
    end

    it "#items_not_shipped" do
      #Expecting to return four because of the six invoices, two have shipped
      expect(@merchant_1.items_not_shipped.count).to eq(4)

      #Expecting the invoice with the earliest created at attribute to be displayed first
      expect(@merchant_1.items_not_shipped.first.invoice.created_at).to eq("1991-03-23 21:40:46")
      expect(@merchant_1.items_not_shipped.last.invoice.created_at).to eq("2021-01-28 21:40:46")
    end

    it "#top_five_items" do
      expect(@merchant_1.top_five_items).to eq([@item_1, @item_2, @item_4, @item_5, @item_6])
    end

    describe 'class methods' do
      it '.merchant_invoices' do
        expect(Merchant.merchant_invoices(@merchant_1.id).count).to eq(6)
        expect(Merchant.merchant_invoices(@merchant_2.id).count).to eq(1)
        expect(Merchant.merchant_invoices(@merchant_3.id).count).to eq(0)
      end
    end

    it '.top_five_merchants' do
      expect(Merchant.top_five_merchants.first).to eq(@merchant_1)
    end
  end
  describe 'instance methods' do
    it '#top_day' do
      expect(@merchant_1.top_day).to eq(@invoice_1.created_at)
    end
  end
end
