require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_one(:merchant).through(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:invoice_id) }
  end

  describe 'class methods' do
    before(:each) do
      @merchant = Merchant.create!(name: 'Ice Cream Parlour')
      @item_1 = @merchant.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
      @item_2 = @merchant.items.create!(name: 'Ice Cream Cones', description: 'holds the ice cream', unit_price: 10)
      @item_3 = @merchant.items.create!(name: 'Sprinkles', description: 'makes ice cream pretty', unit_price: 3)
      @customer = Customer.create!(first_name: 'Stuart', last_name: 'Little')
      @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 13, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 10, status: 0)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 3, status: 0)
    end

    describe '::total_revenue' do
      it 'can calculate total revenue for all invoice_items' do
        expect(InvoiceItem.total_revenue).to eq("78.00")
      end
    end

    describe '::best_item_sale_day' do
      it 'displays the best sale day of the items' do
        #update to include revenue and names, need to add
        #invoice_items and transactions to the before each
        #want to use factory bot for the sake of time
      end
    end
  end
end
