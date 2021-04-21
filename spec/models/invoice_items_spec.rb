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
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 20, status: 1)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_4.id, quantity: 3, unit_price: 20, status: 1)
      @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_5.id, quantity: 4, unit_price: 20, status: 2)
      @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 5, unit_price: 20, status: 2)
      @invoice_item_5 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_7.id, quantity: 500, unit_price: 20, status: 0)

      @transaction_1 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_1.id}")
      @transaction_2 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_2.id}")
      @transaction_3 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_3.id}")
      @transaction_4 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_4.id}")
      @transaction_5 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_5.id}")
      @transaction_6 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_6.id}")
      @transaction_7 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "failed", invoice_id: "#{@invoice_7.id}")
    end

    describe '::total_revenue' do
      it 'can calculate total revenue for all invoice_items' do
        expect(InvoiceItem.total_revenue).to eq(10300)
      end
    end

    describe '::best_item_sale_day' do
      it 'displays the best sale day of the items' do
        expect(InvoiceItem.best_item_sale_day.strftime("%A, %B %d, %Y")).to eq(@item_1.created_at.strftime("%A, %B %d, %Y"))
      end
    end

    describe '::items_not_shipped' do
      it 'finds the item name and invoice id of invoice items that are ready to ship' do
        expect(InvoiceItem.items_not_shipped.to_a.count).to eq(4)
        expect(InvoiceItem.items_not_shipped[0].name).to eq(@item_1.name)
        expect(InvoiceItem.items_not_shipped[1].name).to eq(@item_2.name)
        expect(InvoiceItem.items_not_shipped[2].name).to eq(@item_3.name)
        expect(InvoiceItem.items_not_shipped[3].name).to eq(@item_6.name)
        expect(InvoiceItem.items_not_shipped[0].id).to eq(@invoice_2.id)
        expect(InvoiceItem.items_not_shipped[1].id).to eq(@invoice_3.id)
        expect(InvoiceItem.items_not_shipped[2].id).to eq(@invoice_4.id)
        expect(InvoiceItem.items_not_shipped[3].id).to eq(@invoice_7.id)
      end
    end
  end
end
