require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'class methods' do
    it '#top_five_customers' do
      expect(@merchant_1.top_five_customers).to eq([@customer_6, @customer_4, @customer_5, @customer_3, @customer_2])
    end

    it '#items_ready_to_ship' do
      packaged_items = [@item_5, @item_6, @item_7, @item_8, @item_9, @item_10, @item_1, @item_2, @item_3, @item_4, @item_5]
      expect(@merchant_1.items_ready_to_ship).to eq(packaged_items.sort)
    end

    # top five items ranked by total revenue generated
    # invoice_item_revenue = invoice_item.unit_price * invoice_item.quantity
    # invoice revenue = sum of all invoice items
    # only invoices with at least one successful transaction should count to revenue
    it '#top_five_items' do
      # expect(@merchant_1.top_five_items).to eq()
    end
  end
end
