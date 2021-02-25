require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:customers).through(:invoices)}
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "Instance Methods" do
    before :each do
      @merchant1 = create(:merchant)

      @item = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant1.id)
      @item3 = create(:item, merchant_id: @merchant1.id)
      @item4 = create(:item, merchant_id: @merchant1.id)
      @item5 = create(:item, merchant_id: @merchant1.id)
      @item6 = create(:item, merchant_id: @merchant1.id)

      @invoice_item = create(:invoice_item_with_invoices, item_id: @item.id, status: 2)
      @invoice_item2 = create(:invoice_item_with_invoices, item_id: @item2.id, status: 2)
      @invoice_item3 = create(:invoice_item_with_invoices, item_id: @item3.id, status: 1)
      @invoice_item4 = create(:invoice_item_with_invoices, item_id: @item4.id, status: 1)
      @invoice_item5 = create(:invoice_item_with_invoices, item_id: @item5.id, status: 0)
      @invoice_item6 = create(:invoice_item_with_invoices, item_id: @item6.id, status: 0)

      @transactions = create_list(:transaction, 6, invoice_id: @invoice_item.invoice.id, result: "success")
      @transactions2 = create_list(:transaction, 7, invoice_id: @invoice_item2.invoice.id, result: "success")
      @transactions3 = create_list(:transaction, 8, invoice_id: @invoice_item3.invoice.id, result: "success")
      @transactions4 = create_list(:transaction, 9, invoice_id: @invoice_item4.invoice.id, result: "success")
      @transactions5 = create_list(:transaction, 10, invoice_id: @invoice_item5.invoice.id, result: "success")
      @transactions6 = create_list(:transaction, 11, invoice_id: @invoice_item6.invoice.id, result: "failed")

      @customer = @invoice_item.invoice.customer
      @customer2 = @invoice_item2.invoice.customer
      @customer3 = @invoice_item3.invoice.customer
      @customer4 = @invoice_item4.invoice.customer
      @customer5 = @invoice_item5.invoice.customer
      @customer6 = @invoice_item6.invoice.customer
    end
    describe "#find_top_customers" do
      it "Should return top 5 based on successful transactions" do
        expect(@merchant1.find_top_customers).to eq([@customer5, @customer4, @customer3, @customer2, @customer])
      end
      it "Shows the number of successful transactions" do
        expect(@merchant1.find_top_customers.first.transaction_count).to eq(10)
      end
    end
    describe "#items_not_shipped" do
      it "Should return items not shipped" do
        expect(@merchant1.items_not_shipped).to eq([@item3, @item4, @item5, @item6])
      end
      it 'should return item invoice ids' do
        expect(@merchant1.items_not_shipped.first.invoice_id).to eq(@invoice_item3.invoice.id)
      end
    end
  end
end
