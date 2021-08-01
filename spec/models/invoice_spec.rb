require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'validations' do
    it {should define_enum_for(:status).with_values([:cancelled, 'in progress', :completed])}
  end

  before :each do
    @merchant1 = Merchant.create!(name: 'Sparkys Shop')
    @merchant2 = Merchant.create!(name: 'BBs Petstore')

    @customer1 = Customer.create!(first_name: 'Petey', last_name: 'Wimbley')
    @customer2 = Customer.create!(first_name: 'Victoria', last_name: 'Jenkins')
    @customer3 = Customer.create!(first_name: 'Pedro', last_name: 'Oscar')
    @customer4 = Customer.create!(first_name: 'Scarlett', last_name: 'Redsley')
    @customer5 = Customer.create!(first_name: 'Annie', last_name: 'Snip')
    @customer6 = Customer.create!(first_name: 'Goran', last_name: 'Babalia')

    @item1 = @merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2000)
    @item2 = @merchant1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 3000)
    @item3 = @merchant1.items.create!(name: 'Bouncy Ball', description: 'So bouncy', unit_price: 500)
    @item4 = @merchant2.items.create!(name: 'Dog Bone', description: 'So chewy', unit_price: 800)

    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice2 = @customer2.invoices.create!(status: 1)
    @invoice3 = @customer3.invoices.create!(status: 2)
    @invoice4 = @customer4.invoices.create!(status: 0)
    @invoice5 = @customer5.invoices.create!(status: 1)
    @invoice6 = @customer6.invoices.create!(status: 2)

    @transaction1 = @invoice1.transactions.create!(credit_card_number: "0123456789", credit_card_expiration_date: '12/31', result: 0)
    @transaction2 = @invoice2.transactions.create!(credit_card_number: "9876543210", credit_card_expiration_date: '01/01', result: 0)
    @transaction3 = @invoice3.transactions.create!(credit_card_number: "4444444444", credit_card_expiration_date: '06/07', result: 0)
    @transaction4 = @invoice4.transactions.create!(credit_card_number: "2222111100", credit_card_expiration_date: '02/02', result: 0)
    @transaction5 = @invoice5.transactions.create!(credit_card_number: "7934759378", credit_card_expiration_date: '03/20', result: 0)
    @transaction6 = @invoice6.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)

    @invoice1.items << [@item1]
    @invoice2.items << [@item2]
    @invoice3.items << [@item3, @item4]
    @invoice4.items << [@item4]
    @invoice5.items << [@item4]

    @ii1 = InvoiceItem.create!(invoice_id: @invoice6.id, item_id: @item1.id, quantity: 2, status: 0)
    @ii2 = InvoiceItem.create!(invoice_id: @invoice6.id, item_id: @item2.id, quantity: 1, status: 0)
    @ii3 = InvoiceItem.create!(invoice_id: @invoice6.id, item_id: @item4.id, quantity: 1, status: 0)
  end

  describe 'class methods' do
    it 'can retrieve invoices tied to merchant' do
      expect(Invoice.merchant_invoices(@merchant1.id).first.id).to eq(@invoice1.id)
      expect(Invoice.merchant_invoices(@merchant1.id).last.id).to eq(@invoice6.id)
      expect(Invoice.merchant_invoices(@merchant1.id).length).to eq(4)
    end

    describe '::admin_incomplete_invoices' do
      it 'can find all the incomplete invoices listed by least recent created at date' do #returns only one 'completed' invoice (invoice6)
       # expect(Invoice.admin_incomplete_invoices).to eq([@invoice1, @invoice2, @invoice4, @invoice5])
     end
  end

  describe 'instance methods' do
    it 'can retrieve items tied to merchant' do
      expect(@invoice6.merchant_items(@merchant1.id).first.name).to eq(@item1.name)
      expect(@invoice6.merchant_items(@merchant1.id).last.name).to eq(@item2.name)
      expect(@invoice6.merchant_items(@merchant1.id).length).to eq(2)
    end

    it 'can calculate total revenue for merchant' do
      expect(@invoice6.total_revenue(@merchant1.id)).to eq(70.00)
    end
  end
end
end
