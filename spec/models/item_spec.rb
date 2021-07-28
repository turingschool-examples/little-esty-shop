require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'class method' do
    before(:each) do
      # 2 means shipped
      # 1 means packaged
      # 0 pending
      @merchant_1 = create(:merchant)
      2.times do
        @customers = create(:customer)
        @invoices = create(:invoice, customer_id: @customers.id)
        @items = create(:item, merchant_id: @merchant_1.id)
        @transactions = create(:transaction, invoice_id: @invoices.id)
        @invoice_item = create(:invoice_item, item_id: @items.id, invoice_id: @invoices.id, status: 1)
      end
      3.times do
        @customers = create(:customer)
        @invoices = create(:invoice, customer_id: @customers.id)
        @items = create(:item, merchant_id: @merchant_1.id)
        @transactions = create(:transaction, invoice_id: @invoices.id)
        @invoice_item = create(:invoice_item, item_id: @items.id, invoice_id: @invoices.id, status: 2)
      end
    end

    it "creates a list of all that have not been shipped" do
      expect(Item.not_yet_shipped).to eq([
                                          {
                                            "name" => Item.all[1].name,
                                            "invoice_id" => Invoice.all[1].id,
                                            "invoice_date" => Invoice.all[1].created_at
                                          },
                                          {
                                            "name" => Item.all[0].name,
                                            "invoice_id" => Invoice.all[0].id,
                                            "invoice_date" => Invoice.all[0].created_at
                                          }
                                          ])
    end
  end
end
