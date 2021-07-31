require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should define_enum_for(:status).with_values([:enabled, :disabled])}
  end

  describe 'instance methods' do
    it 'can transform unit price to dollars' do
      merchant1 = Merchant.create!(name: 'Sparkys Shop')
      item = merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2050)

      expect(item.price_to_dollars).to eq(20.50)
    end
  end

  describe 'class methods' do
    before :each do
      @merchant1 = Merchant.create!(name: 'Sparkys Shop')
      @merchant2 = Merchant.create!(name: 'BBs Petstore')

      @customer1 = Customer.create!(first_name: 'Petey', last_name: 'Wimbley')
      @customer2 = Customer.create!(first_name: 'Victoria', last_name: 'Jenkins')
      @customer3 = Customer.create!(first_name: 'Pedro', last_name: 'Oscar')
      @customer4 = Customer.create!(first_name: 'Scarlett', last_name: 'Redsley')
      @customer5 = Customer.create!(first_name: 'Annie', last_name: 'Snip')
      @customer6 = Customer.create!(first_name: 'Goran', last_name: 'Babalia')

      @item1 = @merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2000, status: 0)
      @item2 = @merchant1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 3000, status: 0)
      @item3 = @merchant1.items.create!(name: 'Bouncy Ball', description: 'So bouncy', unit_price: 500, status: 1)
      @item4 = @merchant1.items.create!(name: 'Dog Bone', description: 'So chewy', unit_price: 800, status: 1)
      @item5 = @merchant2.items.create!(name: 'Doll', description: 'So pretty', unit_price: 2500, status: 0)

      @invoice1 = @customer1.invoices.create!(status: 2, created_at: "2012-03-20 09:54:09 UTC")
      @invoice2 = @customer2.invoices.create!(status: 2, created_at: "2012-03-21 09:54:09 UTC")
      @invoice3 = @customer3.invoices.create!(status: 2, created_at: "2012-03-22 09:54:09 UTC")
      @invoice4 = @customer4.invoices.create!(status: 2, created_at: "2012-03-23 09:54:09 UTC")
      @invoice5 = @customer5.invoices.create!(status: 2, created_at: "2012-03-24 09:54:09 UTC")
      @invoice6 = @customer6.invoices.create!(status: 2, created_at: "2012-03-25 09:54:09 UTC")

      @transaction1 = @invoice5.transactions.create!(credit_card_number: "0123456789", credit_card_expiration_date: '12/31', result: 0)
      @transaction2 = @invoice5.transactions.create!(credit_card_number: "9876543210", credit_card_expiration_date: '01/01', result: 0)
      @transaction3 = @invoice5.transactions.create!(credit_card_number: "4444444444", credit_card_expiration_date: '06/07', result: 0)
      @transaction4 = @invoice5.transactions.create!(credit_card_number: "2222111100", credit_card_expiration_date: '02/02', result: 0)
      @transaction5 = @invoice5.transactions.create!(credit_card_number: "7934759378", credit_card_expiration_date: '03/20', result: 0)
      @transaction6 = @invoice6.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)

      @ii1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, status: 1)
      @ii2 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item2.id, status: 1)
      @ii3 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item3.id, status: 0)
      @ii4 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item4.id, status: 2)
      @ii5 = InvoiceItem.create!(invoice_id: @invoice5.id, item_id: @item5.id, status: 1)
    end

    it 'can retrieve items ready to ship' do
      expect(Item.ready_to_ship(@merchant1.id).first.id).to eq(@item1.id)
      expect(Item.ready_to_ship(@merchant1.id).last.id).to eq(@item2.id)
    end

    it 'can retrieve enabled items' do
      expect(Item.enabled).to eq([@item1, @item2, @item5])
    end

    it 'can retrieve disabled items' do
      expect(Item.disabled).to eq([@item3, @item4])
    end
  end
end
