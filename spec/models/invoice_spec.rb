require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
    it {should belong_to(:customer)}
  end

  describe 'validations' do
    it {should validate_presence_of(:status)}
  end

  describe 'instance methods' do
    before(:each) do
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer_1)
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1)
    end

    describe '#format_date_long' do
      it 'returns the date in specified story format Wednesday, January 04, 2023' do
        expected = "Wednesday, January 04, 2023"
        
        expect("2023-01-04 16:29:30 +0000".to_datetime.to_formatted_s(:admin_invoice_date)).to eq(expected)
      end
    end

    describe '#invoice_item' do
      it 'returns the invoice item associated with the item specified' do
        expect(@invoice_1.invoice_item(@item_1).quantity).to eq(@invoice_item_1.quantity)
        expect(@invoice_1.invoice_item(@item_1).unit_price).to eq(@invoice_item_1.unit_price)
        expect(@invoice_1.invoice_item(@item_1).status).to eq(@invoice_item_1.status)
      end
    end
  end
end