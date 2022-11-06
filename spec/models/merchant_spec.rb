require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel', status: 'enabled')
    @merchant2 = Merchant.create!(name: 'D.C.', status: 'disabled')
    @merchant3 = Merchant.create!(name: 'Honey Bee', status: 'enabled')
    @merchant4 = Merchant.create!(name: 'Dancing Dandelions', status: 'disabled')
    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')
    @customer2 = Customer.create!(first_name: 'Clark', last_name: 'Kent')
    @customer3 = Customer.create!(first_name: 'Louis', last_name: 'Lane')
    @customer4 = Customer.create!(first_name: 'Lex', last_name: 'Luther')
    @customer5 = Customer.create!(first_name: 'Frank', last_name: 'Castle')
    @customer6 = Customer.create!(first_name: 'Matt', last_name: 'Murdock')
    @customer7 = Customer.create!(first_name: 'Bruce', last_name: 'Wayne')
    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer2.id)
    @invoice3 = Invoice.create!(status: 'completed', customer_id: @customer3.id)
    @invoice4 = Invoice.create!(status: 'cancelled', customer_id: @customer4.id)
    @invoice5 = Invoice.create!(status: 'completed', customer_id: @customer5.id)
    @invoice6 = Invoice.create!(status: 'completed', customer_id: @customer6.id)
    @invoice7 = Invoice.create!(status: 'completed', customer_id: @customer7.id)
    @invoice8 = Invoice.create!(status: 'completed', customer_id: @customer1.id)
    @invoice9 = Invoice.create!(status: 'completed', customer_id: @customer2.id)
    @invoice10 = Invoice.create!(status: 'completed', customer_id: @customer2.id)
    @invoice11 = Invoice.create!(status: 'completed', customer_id: @customer3.id)
    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant2.id)
    InvoiceItem.create!(quantity: 5, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice2.id)
    InvoiceItem.create!(quantity: 6, unit_price: 100, status: 'pending', item_id: @item1.id, invoice_id: @invoice3.id)
    InvoiceItem.create!(quantity: 12, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice4.id)
    InvoiceItem.create!(quantity: 8, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice5.id)
    InvoiceItem.create!(quantity: 20, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice6.id)
    InvoiceItem.create!(quantity: 50, unit_price: 500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice7.id)
    InvoiceItem.create!(quantity: 15, unit_price: 500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice8.id)
    InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice9.id)
    InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice10.id)
    InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice11.id)
    @transaction1 = Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice1.id)
    @transaction3 = Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice2.id)
    @transaction4 = Transaction.create!(credit_card_number: '4923661117104166', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice3.id)
    @transaction5 = Transaction.create!(credit_card_number: '4536896899874279', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice4.id)
    @transaction6 = Transaction.create!(credit_card_number: '4536896899874280', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice4.id)
    @transaction7 = Transaction.create!(credit_card_number: '4536896899874281', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice5.id)
    @transaction8 = Transaction.create!(credit_card_number: '4536896899874286', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice6.id)
    @transaction9 = Transaction.create!(credit_card_number: '4636896899874290', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice6.id)
    @transaction10 = Transaction.create!(credit_card_number: '4636896899874291', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @transaction11 = Transaction.create!(credit_card_number: '4636896899874298', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice8.id)
    @transaction12 = Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice9.id)
    @transaction13 = Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice10.id)
    @transaction14 = Transaction.create!(credit_card_number: '4636896899845752', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice11.id)
  end

  describe 'instance methods' do
    it 'can return top 5 customers with most transactions' do
      expect(@merchant1.top_merchant_transactions).to eq([@customer2, @customer3, @customer1, @customer5, @customer6])
      expect(@merchant1.top_merchant_transactions.length).to eq(5)
    end

    it 'can return items that are ready to ship' do
      expect(@merchant1.items_ready_to_ship).to eq([@item1, @item1, @item1, @item1, @item1])
      expect(@merchant1.items_ready_to_ship[0].invoice_id).to eq(@invoice1.id)
      expect(@merchant1.items_ready_to_ship[1].invoice_id).to eq(@invoice3.id)
      expect(@merchant1.items_ready_to_ship[2].invoice_id).to eq(@invoice4.id)
      expect(@merchant1.items_ready_to_ship[3].invoice_id).to eq(@invoice5.id)
      expect(@merchant1.items_ready_to_ship[4].invoice_id).to eq(@invoice6.id)
    end

    it 'can return top 5 items by revenue' do
      @item3 = Item.create!(name: 'Bat Mask', description: 'Identity Protection', unit_price: 800, merchant_id: @merchant1.id)
      @item4 = Item.create!(name: 'Leotard', description: 'Costume', unit_price: 1850, merchant_id: @merchant1.id)
      @item5 = Item.create!(name: 'Cape', description: 'Fully Functional', unit_price: 900, merchant_id: @merchant1.id)
      @item6 = Item.create!(name: 'Black Makeup', description: 'Gallon Sized', unit_price: 50, merchant_id: @merchant1.id)
      @item7 = Item.create!(name: 'Batmobile', description: 'Only one left in stock', unit_price: 1000000, merchant_id: @merchant1.id)
      @item8 = Item.create!(name: 'Night-Vision Goggles', description: 'Required for night activities', unit_price: 15000, merchant_id: @merchant1.id)
      @item9 = Item.create!(name: 'Bat-Cave', description: 'Bats not included', unit_price: 10000000, merchant_id: @merchant2.id)
      @invoice12 = Invoice.create!(status: 'completed', customer_id: @customer7.id)
      @invoice13 = Invoice.create!(status: 'completed', customer_id: @customer7.id)
      @invoice14 = Invoice.create!(status: 'completed', customer_id: @customer2.id)
      @invoice15 = Invoice.create!(status: 'completed', customer_id: @customer7.id)
      @invoice16 = Invoice.create!(status: 'completed', customer_id: @customer7.id)
      @invoice17 = Invoice.create!(status: 'completed', customer_id: @customer7.id)
      @invoice18 = Invoice.create!(status: 'completed', customer_id: @customer7.id)
      InvoiceItem.create!(quantity: 50, unit_price: 800, status: 'shipped', item_id: @item3.id, invoice_id: @invoice12.id)
      InvoiceItem.create!(quantity: 100, unit_price: 1850, status: 'shipped', item_id: @item4.id, invoice_id: @invoice13.id)
      InvoiceItem.create!(quantity: 20, unit_price: 900, status: 'shipped', item_id: @item5.id, invoice_id: @invoice14.id)
      InvoiceItem.create!(quantity: 100, unit_price: 50, status: 'shipped', item_id: @item6.id, invoice_id: @invoice15.id)
      InvoiceItem.create!(quantity: 1, unit_price: 1000000, status: 'shipped', item_id: @item7.id, invoice_id: @invoice16.id)
      InvoiceItem.create!(quantity: 5, unit_price: 15000, status: 'shipped', item_id: @item8.id, invoice_id: @invoice17.id)
      InvoiceItem.create!(quantity: 1, unit_price: 10000000, status: 'shipped', item_id: @item9.id, invoice_id: @invoice18.id)
      @transaction15 = Transaction.create!(credit_card_number: '4801647818676137', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice12.id)
      @transaction16 = Transaction.create!(credit_card_number: '4801647818676138', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice13.id)
      @transaction17 = Transaction.create!(credit_card_number: '4801647818676139', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice14.id)
      @transaction18 = Transaction.create!(credit_card_number: '4801647818676146', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice15.id)
      @transaction19 = Transaction.create!(credit_card_number: '4801647818676147', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice16.id)
      @transaction20 = Transaction.create!(credit_card_number: '4801647818676148', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice17.id)
      @transaction21 = Transaction.create!(credit_card_number: '4801647818676149', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice18.id)
      expect(@merchant1.top_items_by_revenue).to eq([@item7, @item4, @item8, @item3, @item5])
    end
  end

  describe 'class methods' do
    describe '#enabled_merchants' do
      it 'returns all merchants with a status of enabled' do
        expect(Merchant.enabled_merchants).to eq([@merchant1, @merchant3])
      end
    end

    describe '#disabled_merchants' do
      it 'returns all merchants with a status of disabled' do
        expect(Merchant.disabled_merchants).to eq([@merchant2, @merchant4])
      end
    end
  end

  describe 'class methods' do
    describe '#enabled_merchants' do
      it 'returns all merchants with a status of enabled' do
        expect(Merchant.enabled_merchants).to eq([@merchant1, @merchant3])
      end
    end

    describe '#disabled_merchants' do
      it 'returns all merchants with a status of disabled' do
        expect(Merchant.disabled_merchants).to eq([@merchant2, @merchant4])
      end
    end
  end
end
