require 'rails_helper'

RSpec.describe Item do
  describe 'associations' do
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price).only_integer }
  end

  describe 'instance methods' do
    describe '#enable_opposite' do
      it "returns the opposite of the item's enable/disable status; " do
        @merchant1 = Merchant.create!(name: 'Tom Holland')
        @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant1.id)

        expect(@item1.enable).to eq('enable')
        expect(@item1.enable_opposite).to eq('disable')
      end
    end
  end

  describe 'class methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Lydia Rodarte-Quayle')
      @item_1 = Item.create!(name: 'P2P', description: 'secret...', unit_price: 1000, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: '10 Gallon Drum', description: 'for storage', unit_price: 100, merchant_id: @merchant_1.id)
      @item_3 = Item.create!(name: 'Dolley', description: 'for transportation', unit_price: 10, merchant_id: @merchant_1.id)

      @customer_1 = Customer.create!(first_name: 'Tuco', last_name: 'Salamanca')
      @customer_1.invoices.create!(status: 1)
      InvoiceItem.create!(invoice: @customer_1.invoices[0], item: @item_1, quantity: 1, unit_price: @item_1.unit_price, status: 1)
      @customer_1.invoices[0].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)
      @customer_1.invoices.create!(status: 1)
      InvoiceItem.create!(invoice: @customer_1.invoices[1], item: @item_2, quantity: 1, unit_price: @item_2.unit_price, status: 1)
      @customer_1.invoices[1].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)

      @customer_2 = Customer.create!(first_name: 'Gustavo', last_name: 'Fring')
      @customer_2.invoices.create!(status: 1)
      InvoiceItem.create!(invoice: @customer_2.invoices[0], item: @item_1, quantity: 2, unit_price: @item_1.unit_price, status: 1)
      @customer_2.invoices[0].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
      @customer_2.invoices.create!(status: 1)
      InvoiceItem.create!(invoice: @customer_2.invoices[1], item: @item_2, quantity: 4, unit_price: @item_2.unit_price, status: 2)
      @customer_2.invoices[1].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
      @customer_2.invoices.create!(status: 0)
      InvoiceItem.create!(invoice: @customer_2.invoices[2], item: @item_3, quantity: 1, unit_price: @item_3.unit_price, status: 1)
      @customer_2.invoices[2].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)

      @merchant_2 = Merchant.create!(name: 'Peter Schuler')
      @item_4 = Item.create!(name: 'P2P', description: 'secret...', unit_price: 800, merchant_id: @merchant_2.id)
      @item_5 = Item.create!(name: '100 Gallon Drum', description: 'for storage', unit_price: 250, merchant_id: @merchant_2.id)
      @item_6 = Item.create!(name: 'Fork Lift', description: 'for transportation', unit_price: 1000, merchant_id: @merchant_2.id)

      @customer_1.invoices.create!(status: 1)
      InvoiceItem.create!(invoice: @customer_1.invoices[2], item: @item_4, quantity: 1, unit_price: @item_4.unit_price, status: 1)
      @customer_1.invoices[2].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)
      @customer_1.invoices.create!(status: 1)
      InvoiceItem.create!(invoice: @customer_1.invoices[3], item: @item_5, quantity: 1, unit_price: @item_5.unit_price, status: 1)
      @customer_1.invoices[3].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)

      @customer_2.invoices.create!(status: 1)
      InvoiceItem.create!(invoice: @customer_2.invoices[3], item: @item_4, quantity: 2, unit_price: @item_4.unit_price, status: 1)
      @customer_2.invoices[3].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
      @customer_2.invoices.create!(status: 1)
      InvoiceItem.create!(invoice: @customer_2.invoices[4], item: @item_5, quantity: 4, unit_price: @item_5.unit_price, status: 2)
      @customer_2.invoices[4].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
      @customer_2.invoices.create!(status: 0)
      InvoiceItem.create!(invoice: @customer_2.invoices[5], item: @item_6, quantity: 1, unit_price: @item_6.unit_price, status: 1)
      @customer_2.invoices[5].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
    end

    describe '::items_ready_to_ship_by_ordered_date' do
      it 'for a given merchant' do
        expected = Item.items_ready_to_ship_by_ordered_date(@merchant_1.id)

        expect(expected.length).to eq(3)
        expect(expected.all? { |item| item.class == Item } ).to be true
        expect(expected[0].invoice_id).to eq(@customer_1.invoices[0].id)
        expect(expected[1].invoice_id).to eq(@customer_1.invoices[1].id)
        expect(expected[2].invoice_id).to eq(@customer_2.invoices[0].id)
      end

      it 'for all merchants' do
        expected = Item.items_ready_to_ship_by_ordered_date

        expect(expected.length).to eq(6)
        expect(expected.all? { |item| item.class == Item } ).to be true
        expect(expected[0].invoice_id).to eq(@customer_1.invoices[0].id)
        expect(expected[1].invoice_id).to eq(@customer_1.invoices[1].id)
        expect(expected[2].invoice_id).to eq(@customer_2.invoices[0].id)
        expect(expected[3].invoice_id).to eq(@customer_1.invoices[2].id)
        expect(expected[4].invoice_id).to eq(@customer_1.invoices[3].id)
        expect(expected[5].invoice_id).to eq(@customer_2.invoices[3].id)
      end
    end

    describe '::enabled_items' do
      it "selects all merchant's items with enabled status" do
        @item_4 = Item.create!(name: 'Hammer', description: 'pound stuff', unit_price: 10_000, merchant_id: @merchant_1.id, enable: 'disable')

        expect(@merchant_1.items.enabled_items).to eq([@item_1, @item_2, @item_3])
      end
    end

    describe '::disabled_items' do
      it "selects all merchant's items with enabled status" do
        @item_4 = Item.create!(name: 'Hammer', description: 'pound stuff', unit_price: 10_000, merchant_id: @merchant_1.id, enable: 'disable')

        expect(@merchant_1.items.disabled_items).to eq([@item_4])
      end
    end
  end
end
