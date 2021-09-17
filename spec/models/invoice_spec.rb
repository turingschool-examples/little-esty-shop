require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @customer_1 = create(:customer)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @invoice_1 = create(:invoice, customer: @customer_1, created_at: "Friday, September 17, 2021" )
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, status: "shipped")
  end

  it 'has merchant invoices' do
    expect(@merchant_1.merchant_invoices).to eq([@invoice_1])
  end

  it 'has the date formated' do
    expect(@invoice_1.date).to eq("Friday, September 17, 2021")
  end
end
