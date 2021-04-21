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
    before(:each) do
      @merchant = create(:merchant)

      @item_1 = create(:item, merchant: @merchant, status: 0)
      @item_2 = create(:item, merchant: @merchant, status: 0)
      @item_3 = create(:item, merchant: @merchant, status: 1)
      @item_4 = create(:item, merchant: @merchant, status: 1)
      @item_5 = create(:item, merchant: @merchant, status: 1)
      @item_6 = create(:item, merchant: @merchant, status: 1)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)
      @customer_7 = create(:customer)

      @invoice_1 = Invoice.create!(status: 0, customer_id: @customer_1.id)
      @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_2.id)
      @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_3.id)
      @invoice_4 = Invoice.create!(status: 0, customer_id: @customer_4.id)
      @invoice_5 = Invoice.create!(status: 0, customer_id: @customer_5.id)
      @invoice_6 = Invoice.create!(status: 0, customer_id: @customer_6.id)
      @invoice_7 = Invoice.create!(status: 2, customer_id: @customer_7.id)

      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 20, status: 1)
      @invoice_item_2 =InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 20, status: 1)
      @invoice_item_3 =InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_4.id, quantity: 3, unit_price: 20, status: 1)
      @invoice_item_4 =InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_5.id, quantity: 4, unit_price: 20, status: 2)
      @invoice_item_5 =InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 5, unit_price: 20, status: 2)
      @invoice_item_5 =InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_7.id, quantity: 500, unit_price: 20, status: 0)

      @transaction_1 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_1.id}")
      @transaction_2 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_2.id}")
      @transaction_3 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_3.id}")
      @transaction_4 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_4.id}")
      @transaction_5 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_5.id}")
      @transaction_6 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_6.id}")
      @transaction_7 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "failed", invoice_id: "#{@invoice_7.id}")
    end

    describe '::disabled_items' do
      it 'finds rows where items are disabled' do
        expect(Item.disabled_items).to eq([@item_1, @item_2, @item_6])
        expect(Item.disabled_items).to_not eq([@item_3, @item_4, @item_5])
      end
    end

    describe '::enabled_items' do
      it 'finds rows where items are enabled' do
        expect(Item.enabled_items).to eq([@item_3, @item_4, @item_5])
        expect(Item.enabled_items).to_not eq([@item_1, @item_2, @item_6])
      end
    end

    describe '::most_popular_items' do
      it 'finds the top five items by revenue for a merchant' do
        expect(Item.most_popular_items).to eq([@item_5, @item_4, @item_3, @item_2, @item_1])
        expect(Item.most_popular_items).to_not eq([@item_6])
      end
    end
  end
end
