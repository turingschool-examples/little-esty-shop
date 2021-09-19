require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of (:name)}
    it { should validate_presence_of (:description)}
    it { should validate_presence_of (:unit_price)}
    it { should validate_presence_of (:status)}
  end

  describe 'invoice information' do
    before(:each) do
      @customer = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @invoice_2 = create(:invoice, customer: @customer, created_at: "Wednesday, September 15, 2021")
      @invoice_3 = create(:invoice, customer: @customer, created_at: Date.new(2021, 9, 17))
      @merchant = create(:merchant)
      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)
      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2)
      @invoice_item_3 = create(:invoice_item, item: @item_2, invoice: @invoice_1)
    end

    it 'can get amount ordered' do
      expect(@item_1.amount(@invoice_1.id)).to eq(@invoice_item_1.quantity)
    end

    it 'can get invoice status' do
      expect(@item_1.order_status(@invoice_1.id)).to eq(@invoice_item_1.status)
    end

    it 'can get sold price' do
      expect(@item_1.sold_price(@invoice_1.id)).to eq(@invoice_item_1.unit_price)
    end

    it 'orders invoices' do
      expect(@item_1.ordered_invoices).to eq([@invoice_1, @invoice_2])
    end
  end
end
