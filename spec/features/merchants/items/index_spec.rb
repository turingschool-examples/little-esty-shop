require 'rails_helper'

RSpec.describe "Merchant_Items", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")
    @merchant_2 = create(:merchant, name: "Trader Bob's deux")

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer_3.id)
    @invoice_4 = create(:invoice, customer_id: @customer_4.id)
    @invoice_5 = create(:invoice, customer_id: @customer_5.id)
    @invoice_6 = create(:invoice, customer_id: @customer_6.id)
    @invoice_7 = create(:invoice, customer_id: @customer_6.id)

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant_2)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, status: "packaged", created_at: Date.new(2023,1,1))
    @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 1, status: "packaged", created_at: Date.new(2023,1,2))
    @invoice_item_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3, quantity: 1, status: "packaged", created_at: Date.new(2023,1,3))
    @invoice_item_4 = create(:invoice_item, item: @item_1, invoice: @invoice_4, quantity: 1, status: "packaged", created_at: Date.new(2023,1,4))
    @invoice_item_5 = create(:invoice_item, item: @item_1, invoice: @invoice_5, quantity: 1, status: "packaged", created_at: Date.new(2023,1,5))
    @invoice_item_6 = create(:invoice_item, item: @item_2, invoice: @invoice_6, quantity: 1, status: "packaged", created_at: Date.new(2023,1,6))
    @invoice_item_7 = create(:invoice_item, item: @item_3, invoice: @invoice_7, quantity: 1, status: "shipped", created_at: Date.new(2023,1,7))

    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    create(:transaction, invoice_id: @invoice_2.id, result: 0)
    create(:transaction, invoice_id: @invoice_3.id, result: 0)
    create(:transaction, invoice_id: @invoice_4.id, result: 0)
    create(:transaction, invoice_id: @invoice_5.id, result: 0)
    create(:transaction, invoice_id: @invoice_7.id, result: 0)
    
    visit "/merchants/#{@merchant.id}/items"
  end

  describe "User Story 6" do
    it "shows a list of all the merchant items" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end
  end
end