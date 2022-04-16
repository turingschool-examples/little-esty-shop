require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe 'instance methods' do
    it 'returns the invoices created at date as Weekday, Month Day, Year' do
      date = 	"2020-02-08 09:54:09 UTC".to_datetime
      cust1 = FactoryBot.create(:customer, first_name: "L'Ron", last_name: 'Hubbard')
      merch1 = FactoryBot.create(:merchant)
      item1 = FactoryBot.create(:item, merchant_id: merch1.id)
      invoice1 = FactoryBot.create(:invoice, created_at: date, customer_id: cust1.id)
      invoice_item_1 = FactoryBot.create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

      expect(invoice1.formatted_created_at).to eq("Saturday, February  8, 2020")
    end

    it 'returns the invoice customers first and last name together' do
      date = 	"2020-02-08 09:54:09 UTC".to_datetime
      cust1 = FactoryBot.create(:customer, first_name: "L'Ron", last_name: 'Hubbard')
      merch1 = FactoryBot.create(:merchant)
      item1 = FactoryBot.create(:item, id: 69, merchant_id: merch1.id)
      invoice1 = FactoryBot.create(:invoice, created_at: date, customer_id: cust1.id)
      invoice_item_1 = FactoryBot.create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

      expect(invoice1.customer_name).to eq("L'Ron Hubbard")
    end
  end

  describe "incomplete invoices" do
    it 'returns a list of all cancelled and in progress invoices' do
        @merchant_1 = create(:merchant)
        @item = create(:item, merchant_id: @merchant_1.id)

        # customer_1, 6 succesful transactions and 1 failed
        @customer_1 = create(:customer)
        @invoice_1 = create(:invoice,status: 0, customer_id: @customer_1.id, created_at: "2012-03-25 09:54:09 UTC")
        @invoice_item_1 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_1.id, status: 2)
        @transactions_list_1 = FactoryBot.create_list(:transaction, 6, invoice_id: @invoice_1.id, result: 0)
        @failed_1 = create(:transaction, invoice_id: @invoice_1.id, result: 1)

        # customer_2 5 succesful transactions
        @customer_2 = create(:customer)
        @invoice_2 = create(:invoice, status: 2, customer_id: @customer_2.id, created_at: "2012-03-25 09:54:09 UTC")
        @invoice_item_2 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_2.id, status: 1)
        transactions_list_2 = FactoryBot.create_list(:transaction, 5, invoice_id: @invoice_2.id, result: 0)
        #customer_3 4 succesful
        @customer_3 = create(:customer)
        @invoice_3 = create(:invoice, status: 1,customer_id: @customer_3.id, created_at: "2012-03-25 09:54:09 UTC")
        @invoice_item_3 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_3.id, status: 2)
        @transactions_list_3 = FactoryBot.create_list(:transaction, 4, invoice_id: @invoice_3.id, result: 0)
      
      expect(Invoice.incomplete_invoices).to eq([@invoice_3])

    end
  end
end
