require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:merchant_id) }
  end

  describe 'class methods' do
    describe '::ordered_items_no_ship' do
      it "finds items that have been ordered but not shipped" do
        @merchant = Merchant.create!(name: 'Ice Cream Parlour')
        @item_1 = @merchant.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
        @item_2 = @merchant.items.create!(name: 'Ice Cream Cone', description: 'holds ice cream', unit_price: 3)
        @customer = Customer.create!(first_name: 'Stuart', last_name: 'Little')
        @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
        @invoice_2 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
        InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 40, status: 0)
        InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 20, status: 2)

        expect(Item.ordered_items_no_ship).to eq([@item_1])
      end
    end
  end
end
