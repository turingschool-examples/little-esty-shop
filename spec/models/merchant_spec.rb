require 'rails_helper'
describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through :items }
    it { should have_many(:invoices).through :invoice_items }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values({enable: 0, disable: 1})}
  end

  describe 'instance and class methods' do
    it '.enabled_merchants' do
      merchant_1 = Merchant.create!(name: 'merchant_1')
      merchant_2 = Merchant.create!(name: 'merchant_2', status: 0)
      merchant_3 = Merchant.create!(name: 'merchant_3')
      merchant_4 = Merchant.create!(name: 'merchant_4', status: 0)

      expect(Merchant.enabled_merchants).to eq([merchant_2, merchant_4])
    end

    it '.disabled_merchants' do
      merchant_1 = Merchant.create!(name: 'merchant_1')
      merchant_2 = Merchant.create!(name: 'merchant_2', status: 0)
      merchant_3 = Merchant.create!(name: 'merchant_3')
      merchant_4 = Merchant.create!(name: 'merchant_4', status: 0)

      expect(Merchant.disabled_merchants).to eq([merchant_1, merchant_3])
    end

    it '.top_five_merchants' do
      merchant_1 = Merchant.create!(name: 'Seth')
      item_1 = create(:item, merchant_id: merchant_1.id)
      customer_1 = create(:customer)
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      transaction_list_1 = FactoryBot.create_list(:transaction, 6, invoice_id: invoice_1.id, result: 0)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, status: 2, quantity: 1, unit_price: 5)

      merchant_2 = Merchant.create!(name: 'John')
      item_2 = create(:item, merchant_id: merchant_2.id)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
      transaction_list_2 = FactoryBot.create_list(:transaction, 5, invoice_id: invoice_2.id, result: 0)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, status: 2, quantity: 1, unit_price: 5)

      merchant_3 = Merchant.create!(name: 'Jim')
      item_3 = create(:item, merchant_id: merchant_3.id)
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
      transaction_list_3 = FactoryBot.create_list(:transaction, 4, invoice_id: invoice_3.id, result: 0)
      invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, status: 2, quantity: 1, unit_price: 5)

      merchant_4 = Merchant.create!(name: 'Ben')
      item_4 = create(:item, merchant_id: merchant_4.id)
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
      transaction_list_4 = FactoryBot.create_list(:transaction, 3, invoice_id: invoice_4.id, result: 0)
      invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_4.id, status: 2, quantity: 1, unit_price: 5)

      merchant_5 = Merchant.create!(name: 'Josh')
      item_5 = create(:item, merchant_id: merchant_5.id)
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
      transaction_list_5 = FactoryBot.create_list(:transaction, 2, invoice_id: invoice_5.id, result: 0)
      invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_5.id, status: 2, quantity: 1, unit_price: 5)

      merchant_6 = Merchant.create!(name: 'Rob')
      item_6 = create(:item, merchant_id: merchant_6.id)
      item_7 = create(:item, merchant_id: merchant_6.id)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      transaction_list_6 = FactoryBot.create_list(:transaction, 1, invoice_id: invoice_6.id, result: 0)
      invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 2, quantity: 1, unit_price: 5)
      invoice_item_7 = create(:invoice_item, item_id: item_7.id, invoice_id: invoice_6.id, status: 1, quantity: 1)
      expect(Merchant.top_five_merchants).to eq([merchant_1, merchant_2, merchant_3, merchant_4, merchant_5])
    end

    it '#best_sales_date' do
      customer_1 = create(:customer)
      merchant_6 = Merchant.create!(name: 'Rob')
      item_6 = create(:item, merchant_id: merchant_6.id, unit_price: 5)
      item_7 = create(:item, merchant_id: merchant_6.id, unit_price: 5)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-25 09:54:09 UTC")
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2016-03-25 09:54:09 UTC")
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2014-03-25 09:54:09 UTC")
      transaction_1 = create(:transaction, invoice_id: invoice_6.id, result: 0)
      transaction_2 = create(:transaction, invoice_id: invoice_7.id, result: 0)
      transaction_3 = create(:transaction, invoice_id: invoice_8.id, result: 0)
      invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 2, quantity: 1, unit_price: 5)
      invoice_item_7 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_7.id, status: 2, quantity: 10, unit_price: 5)
      invoice_item_8 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_8.id, status: 2, quantity: 10, unit_price: 5)
      expect(merchant_6.best_sales_date).to eq(invoice_7.created_at)
    end

    describe '#ordered_items_to_ship' do
      it 'returns items with incompleted invoices, ordered by creation' do
        merchant = create :merchant
        item1 = create :item, { merchant_id: merchant.id, id: 1 }
        item2 = create :item, { merchant_id: merchant.id, id: 2 }
        item4 = create :item, { merchant_id: merchant.id, id: 3 }
        item3 = create :item, { merchant_id: merchant.id, id: 4 }
        invoice1 = create :invoice, { status: 0 }
        invoice2 = create :invoice, { status: 1 }
        invoice3 = create :invoice, { status: 2 }
        invoice_item1 = create :invoice_item, { invoice_id: invoice1.id, item_id: item1.id, status: 0 }
        invoice_item2 = create :invoice_item, { invoice_id: invoice3.id, item_id: item2.id, status: 1 }
        invoice_item3 = create :invoice_item, { invoice_id: invoice2.id, item_id: item3.id, status: 2 }
        invoice_item4 = create :invoice_item, { invoice_id: invoice1.id, item_id: item4.id, status: 0 }

        expect(merchant.ordered_items_to_ship).to eq([item1, item2, item4])
      end
    end
  end
end
