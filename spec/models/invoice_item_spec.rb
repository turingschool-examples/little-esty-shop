require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_many(:discounts).through(:merchants) }
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
  end
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @merchant2 = Merchant.create!(name: 'Honey Bee', status: 'enabled')

    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100,
                          merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 100, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'Bat Mask', description: 'Identity Protection', unit_price: 800,
                          merchant_id: @merchant2.id)

    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: Time.parse('19.07.18'))
    @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: '2010-03-11 01:51:45')

    @ii1 = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    @ii2 = InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'packaged', item_id: @item2.id, invoice_id: @invoice1.id)
    @ii3 = InvoiceItem.create!(quantity: 50, unit_price: 800, status: 'shipped', item_id: @item3.id, invoice_id: @invoice2.id)

    @discount1 = Discount.create!(merchant_id: @merchant1.id, quantity_threshhold: 5, percentage: 0.2, invoice_item_id: @ii1.id)
    # @discount2 = Discount.create!(merchant_id: @merchant1.id, quantity_threshhold: 15, percentage: 0.4, invoice_item_id: @ii2.id)
    # @discount2 = Discount.create!(merchant_id: @merchant2.id, quantity_threshhold: 212, percentage: 0.4, invoice_item_id: @ii3.id)
  end
  describe 'total_revenue' do
    it 'joins with merchant and gets total of quantity * unit price' do
      expect(InvoiceItem.total_revenue(@merchant1.id)).to eq(2000)
    end
    describe 'discounted' do
      it 'totals revenue including discounts' do
        expect(InvoiceItem.discounted(@merchant1.id)).to eq(400.0)
      end
    end
  end
end
