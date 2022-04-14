require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'instance and class methods' do

    it "#top_five_customers" do
      merchant_1 = create(:merchant)
          item = create(:item, merchant_id: merchant_1.id)
          # customer_1, 6 succesful transactions and 1 failed
          customer_1 = create(:customer)
          invoice_1 = create(:invoice, customer_id: customer_1.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice_1.id, status: 2)
          transactions_list_1 = FactoryBot.create_list(:transaction, 6, invoice_id: invoice_1.id, result: 0)
          failed_1 = create(:transaction, invoice_id: invoice_1.id, result: 1)
          # customer_2 5 succesful transactions
          customer_2 = create(:customer)
          invoice_2 = create(:invoice, customer_id: customer_2.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id, status: 2)
          transactions_list_2 = FactoryBot.create_list(:transaction, 5, invoice_id: invoice_2.id, result: 0)
          #customer_3 4 succesful
          customer_3 = create(:customer)
          invoice_3 = create(:invoice, customer_id: customer_3.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice_3.id, status: 2)
          transactions_list_3 = FactoryBot.create_list(:transaction, 4, invoice_id: invoice_3.id, result: 0)
          #customer_6 1 succesful
          customer_6 = create(:customer)
          invoice_6 = create(:invoice, customer_id: customer_6.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_6 = create(:invoice_item, item_id: item.id, invoice_id: invoice_6.id, status: 2)
          transactions_list_6 = FactoryBot.create_list(:transaction, 1, invoice_id: invoice_6.id, result: 0)
          #customer_4 3 succesful
          customer_4 = create(:customer)
          invoice_4 = create(:invoice, customer_id: customer_4.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_4 = create(:invoice_item, item_id: item.id, invoice_id: invoice_4.id, status: 2)
          transactions_list_4 = FactoryBot.create_list(:transaction, 3, invoice_id: invoice_4.id, result: 0)
          #customer_5 2 succesful
          customer_5 = create(:customer)
          invoice_5 = create(:invoice, customer_id: customer_5.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_5 = create(:invoice_item, item_id: item.id, invoice_id: invoice_5.id, status: 2)
          transactions_list_5 = FactoryBot.create_list(:transaction, 2, invoice_id: invoice_5.id, result: 0)

          expect(merchant_1.top_five_customers).to eq([customer_1, customer_2, customer_3, customer_4, customer_5])
    end

    it 'returns #unique_invoices for a given merchant' do
      merch1 = FactoryBot.create(:merchant)
      item1 = FactoryBot.create(:item, merchant_id: merch1.id)
      item2 = FactoryBot.create(:item, merchant_id: merch1.id)
      item3 = FactoryBot.create(:item, merchant_id: merch1.id)
      cust1 = FactoryBot.create(:customer)

      invoice1 = FactoryBot.create(:invoice, customer_id: cust1.id)
      invoice_item_1 = FactoryBot.create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

      invoice2 = FactoryBot.create(:invoice, customer_id: cust1.id)
      invoice_item_2 = FactoryBot.create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)

      invoice3 = FactoryBot.create(:invoice, customer_id: cust1.id)
      invoice_item_3 = FactoryBot.create(:invoice_item, item_id: item1.id, invoice_id: invoice3.id)
      invoice_item_4 = FactoryBot.create(:invoice_item, item_id: item2.id, invoice_id: invoice3.id)

      expect(merch1.unique_invoices).to eq([invoice1, invoice2, invoice3])
    end

    it "#items_ready_to_ship" do
      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, status: 1)
      date_1 = 	"2015-02-08 09:54:09 UTC".to_datetime
      date_2 = 	"2020-02-21 09:54:09 UTC".to_datetime
      date_3 = 	"2018-03-12 09:54:09 UTC".to_datetime
      invoice_item_1 = create(:invoice_item, status: 0, item_id: item_1.id, invoice_id: invoice.id, created_at: date_1)
      invoice_item_2 = create(:invoice_item, status: 0, item_id: item_1.id, invoice_id: invoice.id, created_at: date_2)
      invoice_item_3 = create(:invoice_item, status: 0, item_id: item_1.id, invoice_id: invoice.id, created_at: date_3)

      expect(merchant_1.ready_to_ship[0]).to eq(invoice_item_1)
      expect(merchant_1.ready_to_ship[1]).to eq(invoice_item_2)
      expect(merchant_1.ready_to_ship[2]).to eq(invoice_item_3)
    end
    it '#current_invoice_items returns a merchants invoice items for a given invoice' do
      merch1 = FactoryBot.create(:merchant)
      merch2 = FactoryBot.create(:merchant)
      cust1 = FactoryBot.create(:customer)
      item1 = FactoryBot.create(:item, merchant_id: merch1.id)
      item2 = FactoryBot.create(:item, merchant_id: merch1.id)
      item3 = FactoryBot.create(:item, merchant_id: merch1.id)
      item4 = FactoryBot.create(:item, merchant_id: merch2.id)

      invoice1 = FactoryBot.create(:invoice, customer_id: cust1.id)
      invoice_item_1 = FactoryBot.create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      invoice_item_2 = FactoryBot.create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id)
      invoice_item_4 = FactoryBot.create(:invoice_item, item_id: item3.id, invoice_id: invoice1.id)
      invoice_item_3 = FactoryBot.create(:invoice_item, item_id: item4.id, invoice_id: invoice1.id)

      invoice2 = FactoryBot.create(:invoice, customer_id: cust1.id)
      invoice_item_5 = FactoryBot.create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)

      # require "pry"; binding.pry
      expect(merch1.current_invoice_items(invoice1.id)).to eq([invoice_item_1, invoice_item_2, invoice_item_4])
    end

    it 'returns the total revenue for a merchant for a given invoice' do
      merch1 = FactoryBot.create(:merchant)
      cust1 = FactoryBot.create(:customer)
      item1 = FactoryBot.create(:item, unit_price: 75107, merchant_id: merch1.id)
      item2 = FactoryBot.create(:item, unit_price: 59999, merchant_id: merch1.id)
      item3 = FactoryBot.create(:item, unit_price: 65734, merchant_id: merch1.id)
      invoice1 = FactoryBot.create(:invoice, customer_id: cust1.id)
      invoice_item_1 = FactoryBot.create(:invoice_item, item_id: item1.id, unit_price: item1.unit_price, quantity: 3, invoice_id: invoice1.id)
      invoice_item_2 = FactoryBot.create(:invoice_item, item_id: item2.id, unit_price: item2.unit_price, quantity: 1, invoice_id: invoice1.id)
      invoice_item_3 = FactoryBot.create(:invoice_item, item_id: item3.id, unit_price: item3.unit_price, quantity: 2, invoice_id: invoice1.id)

      invoice2 = FactoryBot.create(:invoice, customer_id: cust1.id)
      invoice_item_5 = FactoryBot.create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)

      expect(merch1.total_revenue_for_invoice(invoice1.id)).to eq(4167.88)
    end


  end
end
