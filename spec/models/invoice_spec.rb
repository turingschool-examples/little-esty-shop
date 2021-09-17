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

  before(:each) do
    @customer = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer)
    @invoice_2 = create(:invoice, customer: @customer)
    @invoice_3 = create(:invoice, customer: @customer, created_at: Date.new(2021, 9, 17))
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @invoice_item_1 = create(:invoice_item, item: @item_1, status: 'shipped', invoice: @invoice_1)
    @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2)
    @invoice_item_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3)
  end

  describe 'class methods' do
    it "gets all incomplete invoices" do
      expect(Invoice.incomplete_invoices).to eq([@invoice_2, @invoice_3])
    end
  end

  describe 'instance methods' do
    it 'formats date' do
      expect(@invoice_3.date).to eq('Friday, September 17, 2021')
    end

    it 'formats customer name' do
      expect(@invoice_3.customer_name).to eq("#{customer.first_name} #{customer.last_name}")
    end
  end
end
