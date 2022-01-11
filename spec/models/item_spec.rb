require 'rails_helper'
describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items}
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'instance and class methods' do
    it '#disabled_items' do
      @merchant1 = Merchant.create!(name: 'Hair Care')

      @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
      @item4 = Item.create!(name: "Shampoo Bar", description: "Eco friendly shampoo", unit_price: 7, merchant_id: @merchant1.id, status: 1)

      expect(@merchant1.disabled_items).to eq([@item1, @item2, @item3])
    end

    it '#enabled_items' do
      @merchant1 = Merchant.create!(name: 'Hair Care')

      @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
      @item4 = Item.create!(name: "Shampoo Bar", description: "Eco friendly shampoo", unit_price: 7, merchant_id: @merchant1.id, status: 1)

      expect(@merchant1.enabled_items).to eq([@item4])
    end

    it '#most_revenue' do
      customer_1 = create(:customer)
      merchant_6 = Merchant.create!(name: 'Rob')
      item_6  = create(:item, name: 'name_1', merchant_id: merchant_6.id)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2013-03-25 09:54:09 UTC")
      invoice_12 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-25 09:54:09 UTC")
      transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_12.id, result: 0)
      invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 2, quantity: 1, unit_price: 50)
      invoice_item_12 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_12.id, status: 2, quantity: 1, unit_price: 50)

      expect(item_6.most_revenue).to eq(invoice_6.created_at.to_date)
    end
  end


  # add validations so that form can't be
  # incomplete. All attributes validated.

end
