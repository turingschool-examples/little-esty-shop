require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'validations' do
    it { should define_enum_for(:enabled).with([:enabled, :disabled]) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'class method' do
    before(:each) do
      @merchant_1 = create(:merchant)

      @customers = []
      @invoices = []
      @items = []
      @transactions = []
      @invoice_items = []

      2.times do
        @customers << create(:customer)
        @invoices << create(:invoice, customer_id: @customers.last.id)
        @items << create(:item, merchant_id: @merchant_1.id)
        @transactions << create(:transaction, invoice_id: @invoices.last.id)
        @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)
      end
      3.times do
        @customers << create(:customer)
        @invoices << create(:invoice, customer_id: @customers.last.id)
        @items << create(:item, merchant_id: @merchant_1.id)
        @transactions << create(:transaction, invoice_id: @invoices.last.id)
        @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 2)
      end
    end

    it "creates a list of all items that have not been shipped" do
      expect(Item.not_yet_shipped).to eq([
                                          {
                                            "name" => @items[1].name,
                                            "invoice_id" => @invoices[1].id,
                                            "invoice_date" => @invoices[1].created_at
                                          },
                                          {
                                            "name" => @items[0].name,
                                            "invoice_id" => @invoices[0].id,
                                            "invoice_date" => @invoices[0].created_at
                                          }
                                          ])
    end
  end
end
