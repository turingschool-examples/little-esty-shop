require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'instance methods' do
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
    it '#top_five_items by revenue' do
      expect(@merchant_1.top_five_items).to eq([@item_4, @item_7, @item_10, @item_6, @item_5])
    end

    it '#top_five_merchants by revenue' do
      merchant_2 = Merchant.create!(name: "Bill")
      merchant_3 = Merchant.create!(name: "Barbara")
      merchant_4 = Merchant.create!(name: "Lizzy")
      merchant_5 = Merchant.create!(name: "Paul")
      merchant_6 = Merchant.create!(name: "Theo")

      most_expensive_item = merchant_2.items.create!(name: "Most Expensive Item", description: "Description", unit_price: 10000000)
      extremely_expensive_item = merchant_3.items.create!(name: "Extremely Expensive Item", description: "Description", unit_price: 5000000)
      mega_expensive_item = merchant_4.items.create!(name: "Mega Expensive Item", description: "Description", unit_price: 2000000)
      super_expensive_item = merchant_5.items.create!(name: "Super Expensive Item", description: "Description", unit_price: 1000000)

      super_rich_customer = Customer.create!(first_name: "Billionaire", last_name: "Person")

      new_invoice_1 = super_rich_customer.invoices.create!
      new_invoice_2 = super_rich_customer.invoices.create!
      new_invoice_3 = super_rich_customer.invoices.create!
      new_invoice_4 = super_rich_customer.invoices.create!

      new_invoice_1.invoice_items.create!(item_id: most_expensive_item.id, quantity: 1, unit_price: most_expensive_item.unit_price, status: 1)
      new_invoice_2.invoice_items.create!(item_id: extremely_expensive_item.id, quantity: 1, unit_price: extremely_expensive_item.unit_price, status: 1)
      new_invoice_3.invoice_items.create!(item_id: mega_expensive_item.id, quantity: 1, unit_price: mega_expensive_item.unit_price, status: 1)
      new_invoice_4.invoice_items.create!(item_id: super_expensive_item.id, quantity: 1, unit_price: super_expensive_item.unit_price, status: 1)

      new_invoice_1.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
      new_invoice_2.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
      new_invoice_3.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
      new_invoice_4.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")

      expected_result = [merchant_2, merchant_3, merchant_4, merchant_5, @merchant_1]

      expect(Merchant.top_five_merchants).to eq(expected_result)
    end

    it '#top_merchant_best_day' do
      expected_result = @merchant_1.top_merchant_best_day.strftime("%A, %B %d, %Y")

      expect(@merchant_1.top_merchant_best_day.strftime("%A, %B %d, %Y")).to eq(expected_result)
    end
  end
end
