require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_numericality_of :unit_price}
    it {should define_enum_for(:status).with_values(["Disabled", "Enabled"])}
  end

  describe 'class methods' do
    it 'returns enabled items' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant, status: 1)
      item2 = create(:item, merchant: merchant, status: 0)
      item3 = create(:item, merchant: merchant, status: 1)

      expect(Item.enabled).to eq([item, item3])
      expect(Item.enabled).to_not eq([item2])
    end

    it 'returns disabled items' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant, status: 1)
      item2 = create(:item, merchant: merchant, status: 0)
      item3 = create(:item, merchant: merchant, status: 1)

      expect(Item.disabled).to eq([item2])
      expect(Item.disabled).to_not eq([item, item3])
    end

    it 'finds the top 5 items' do
      merchant = create(:merchant)
      customer = create(:customer)
      items = create_list(:item, 6, merchant: merchant)
      invoices = create_list(:invoice, 3, customer: customer)

      transaction1 = create(:transaction, invoice: invoices[0], result: 1)
      transaction2 = create(:transaction, invoice: invoices[0], result: 1)
      transaction3 = create(:transaction, invoice: invoices[1], result: 0)
      transaction4 = create(:transaction, invoice: invoices[1], result: 1)
      transaction5 = create(:transaction, invoice: invoices[2], result: 0)
      transaction6 = create(:transaction, invoice: invoices[2], result: 0)

      invoice_item1 = create(:invoice_item, item: items[0], invoice: invoices[0], quantity: 42, unit_price: 500000000)
      invoice_item2 = create(:invoice_item, item: items[1], invoice: invoices[1], quantity: 3, unit_price: 2000)
      invoice_item3 = create(:invoice_item, item: items[2], invoice: invoices[1], quantity: 5, unit_price: 3000)
      invoice_item4 = create(:invoice_item, item: items[3], invoice: invoices[2], quantity: 16, unit_price: 4000)
      invoice_item5 = create(:invoice_item, item: items[4], invoice: invoices[1], quantity: 2, unit_price: 6000)
      invoice_item6 = create(:invoice_item, item: items[5], invoice: invoices[2], quantity: 4, unit_price: 5000)
      invoice_item7 = create(:invoice_item, item: items[0], invoice: invoices[0], quantity: 6, unit_price: 1)
      invoice_item8 = create(:invoice_item, item: items[1], invoice: invoices[2], quantity: 22, unit_price: 2)
      invoice_item9 = create(:invoice_item, item: items[2], invoice: invoices[2], quantity: 63, unit_price: 3)
      invoice_item10 = create(:invoice_item, item: items[3], invoice: invoices[2], quantity: 1, unit_price: 4)
      invoice_item11 = create(:invoice_item, item: items[4], invoice: invoices[1], quantity: 7, unit_price: 5)
      invoice_item12 = create(:invoice_item, item: items[5], invoice: invoices[1], quantity: 9, unit_price: 6)

      expect(Item.most_popular).to eq([items[3], items[5], items[2], items[4], items[1]])
    end
  end

  describe "#instance methods" do
    it "#best_day returns the item's best selling day" do
      merchant = create(:merchant)
      customer = create(:customer)
      items = create_list(:item, 6, merchant: merchant)

      invoice1 = create(:invoice, customer: customer, created_at: "2012-03-10 00:54:09 UTC")
      invoice2 = create(:invoice, customer: customer, created_at: "2012-03-10 00:54:09 UTC")
      invoice3 = create(:invoice, customer: customer, created_at: "2022-03-10 00:54:09 UTC")

      transaction1 = create(:transaction, invoice: invoice1, result: 1)
      transaction2 = create(:transaction, invoice: invoice1, result: 1)
      transaction3 = create(:transaction, invoice: invoice2, result: 0)
      transaction4 = create(:transaction, invoice: invoice2, result: 1)
      transaction5 = create(:transaction, invoice: invoice3, result: 0)
      transaction6 = create(:transaction, invoice: invoice3, result: 0)

      invoice_item1 = create(:invoice_item, item: items[0], invoice: invoice1, quantity: 42, unit_price: 500000000)
      invoice_item7 = create(:invoice_item, item: items[0], invoice: invoice1, quantity: 6, unit_price: 1)
      invoice_item2 = create(:invoice_item, item: items[1], invoice: invoice2, quantity: 3, unit_price: 2000)
      invoice_item8 = create(:invoice_item, item: items[1], invoice: invoice3, quantity: 22, unit_price: 2)
      invoice_item3 = create(:invoice_item, item: items[2], invoice: invoice2, quantity: 5, unit_price: 3000)
      invoice_item9 = create(:invoice_item, item: items[2], invoice: invoice3, quantity: 63, unit_price: 3)
      invoice_item4 = create(:invoice_item, item: items[3], invoice: invoice3, quantity: 16, unit_price: 4000)
      invoice_item10 = create(:invoice_item, item: items[3], invoice: invoice3, quantity: 1, unit_price: 4)
      invoice_item5 = create(:invoice_item, item: items[4], invoice: invoice2, quantity: 2, unit_price: 6000)
      invoice_item11 = create(:invoice_item, item: items[4], invoice: invoice2, quantity: 7, unit_price: 5)
      invoice_item6 = create(:invoice_item, item: items[5], invoice: invoice3, quantity: 9, unit_price: 5000)
      invoice_item12 = create(:invoice_item, item: items[5], invoice: invoice2, quantity: 9, unit_price: 6)

      expect(items[1].best_day).to eq(invoice3.created_at.strftime("%m/%d/%y"))
      expect(items[2].best_day).to eq(invoice3.created_at.strftime("%m/%d/%y"))
      expect(items[3].best_day).to eq(invoice3.created_at.strftime("%m/%d/%y"))
      expect(items[4].best_day).to eq(invoice2.created_at.strftime("%m/%d/%y"))
      expect(items[5].best_day).to eq(invoice3.created_at.strftime("%m/%d/%y"))
    end
  end
end
