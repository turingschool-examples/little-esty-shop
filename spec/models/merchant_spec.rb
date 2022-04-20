require "rails_helper"

RSpec.describe Merchant do
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")

    @item_1 = @merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
    @item_2 = @merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)
    @item_3 = @merch_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)
    @item_4 = @merch_1.items.create!(name: "Double Legged Pant", description: "pants built for people with two legs", unit_price: 50000)
    @item_5 = @merch_1.items.create!(name: "Stainless Steel, 5-Pocket Jean", description: "Shorts of Steel", unit_price: 3000000)
    @item_6 = @merch_1.items.create!(name: "String of Numbers", description: "54921752964273", unit_price: 100)

    @cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
    @cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")
    @cust_3 = Customer.create!(first_name: "Brian", last_name: "Twinlegs")
    @cust_4 = Customer.create!(first_name: "Jared", last_name: "Goffleg")
    @cust_5 = Customer.create!(first_name: "Pistol", last_name: "Pete")
    @cust_6 = Customer.create!(first_name: "Bronson", last_name: "Shmonson")
    @cust_7 = Customer.create!(first_name: "Anten", last_name: "Branden")

    @invoice_1 = @cust_1.invoices.create!(status: 1, created_at: "12/30/2011")
    @invoice_2 = @cust_1.invoices.create!(status: 1, created_at: "06/15/2016")
    @invoice_3 = @cust_1.invoices.create!(status: 1, created_at: "03/14/2009")
    @invoice_4 = @cust_2.invoices.create!(status: 1, created_at: "04/04/2019")
    @invoice_5 = @cust_2.invoices.create!(status: 1, created_at: "07/13/2008")
    @invoice_6 = @cust_2.invoices.create!(status: 1, created_at: "10/11/2020")
    @invoice_7 = @cust_3.invoices.create!(status: 1, created_at: "03/14/2011")
    @invoice_8 = @cust_3.invoices.create!(status: 1, created_at: "03/14/2009")
    @invoice_9 = @cust_4.invoices.create!(status: 1, created_at: "03/14/2009")
    @invoice_10 = @cust_4.invoices.create!(status: 1, created_at: "03/14/2009")
    @invoice_11 = @cust_5.invoices.create!(status: 1, created_at: "03/14/2009")
    @invoice_12 = @cust_5.invoices.create!(status: 1, created_at: "03/14/2009")
    @invoice_13 = @cust_6.invoices.create!(status: 1, created_at: "03/14/2009")
    @invoice_14 = @cust_7.invoices.create!(status: 1, created_at: "03/14/2009")
    @invoice_15 = @cust_7.invoices.create!(status: 2, created_at: "03/14/2009")

    @ii_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_3 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_6 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_7 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_7.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_8 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_8.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_9 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_9.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_10 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_10.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)

    @ii_11 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_11.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_12 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_12.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_13 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_13.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    @ii_14 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_14.id, quantity: 500, unit_price: @item_4.unit_price, status: 2)
    @ii_15 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_14.id, quantity: 1, unit_price: @item_4.unit_price, status: 2)
    @ii_16 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_14.id, quantity: 30, unit_price: @item_1.unit_price, status: 2)
    @ii_17 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_14.id, quantity: 30, unit_price: @item_2.unit_price, status: 2)
    @ii_18 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_14.id, quantity: 30, unit_price: @item_3.unit_price, status: 2)
    @ii_19 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_15.id, quantity: 700, unit_price: @item_4.unit_price, status: 0)

    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    @transaction_6 = @invoice_6.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    @transaction_7 = @invoice_7.transactions.create!(credit_card_number: 4364756374652636, result: "success")
    @transaction_8 = @invoice_8.transactions.create!(credit_card_number: 4364756374652636, result: "success")
    @transaction_9 = @invoice_9.transactions.create!(credit_card_number: 4928294837461125, result: "success")
    @transaction_10 = @invoice_10.transactions.create!(credit_card_number: 4928294837461125, result: "success")
    @transaction_11 = @invoice_11.transactions.create!(credit_card_number: 4738473664751832, result: "success")
    @transaction_12 = @invoice_12.transactions.create!(credit_card_number: 4738473664751832, result: "success")
    @transaction_13 = @invoice_13.transactions.create!(credit_card_number: 4023948573948293, result: "success")
    @transaction_14 = @invoice_14.transactions.create!(credit_card_number: 4023948573948293, result: "success")
    @transaction_15 = @invoice_15.transactions.create!(credit_card_number: 4023948573948293, result: "success")
  end

  describe "relationships" do
    it { should have_many(:items) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "class methods" do
    before do
      @merch_2 = Merchant.create!(name: "Store Two", status: "enabled")
      @merch_3 = Merchant.create!(name: "Store three", status: "disabled")
      @merch_4 = Merchant.create!(name: "Store four", status: "enabled")
      @merch_5 = Merchant.create!(name: "Store five")
      @merch_6 = Merchant.create!(name: "Store six", status: "disabled")

      @m2_item = @merch_2.items.create!(name: "Merch 2 Item", description: "Item belongs to m2", unit_price: 20000)
      @m3_item = @merch_3.items.create!(name: "Merch 3 Item", description: "Item belongs to m3", unit_price: 30000)
      @m4_item = @merch_4.items.create!(name: "Merch 4 Item", description: "Item belongs to m4", unit_price: 40000)
      @m5_item = @merch_5.items.create!(name: "Merch 5 Item", description: "Item belongs to m5", unit_price: 50000)
      @m6_item = @merch_6.items.create!(name: "Merch 6 Item", description: "Item belongs to m6", unit_price: 60000)

      @test_custy = Customer.create!(first_name: "Test", last_name: "Custy")

      @m2_inv = @test_custy.invoices.create!(status: 1)
      @m3_inv = @test_custy.invoices.create!(status: 1)
      @m4_inv = @test_custy.invoices.create!(status: 1)
      @m5_inv = @test_custy.invoices.create!(status: 1)
      @m6_inv0 = @test_custy.invoices.create!(status: 0)
      @m6_inv2 = @test_custy.invoices.create!(status: 2)

      @m2_ii = InvoiceItem.create!(item_id: @m2_item.id, invoice_id: @m2_inv.id, quantity: 1, unit_price: @m2_item.unit_price, status: 2)
      @m3_ii = InvoiceItem.create!(item_id: @m3_item.id, invoice_id: @m3_inv.id, quantity: 4, unit_price: @m3_item.unit_price, status: 2)
      @m4_ii = InvoiceItem.create!(item_id: @m4_item.id, invoice_id: @m4_inv.id, quantity: 1, unit_price: @m4_item.unit_price, status: 2)
      @m5_ii = InvoiceItem.create!(item_id: @m5_item.id, invoice_id: @m5_inv.id, quantity: 3, unit_price: @m5_item.unit_price, status: 2)
      @m6_ii0 = InvoiceItem.create!(item_id: @m6_item.id, invoice_id: @m6_inv0.id, quantity: 10, unit_price: @m6_item.unit_price, status: 0)
      @m6_ii2 = InvoiceItem.create!(item_id: @m6_item.id, invoice_id: @m6_inv2.id, quantity: 10, unit_price: @m6_item.unit_price, status: 0)

      @m2_tr = @m2_inv.transactions.create!(credit_card_number: 4039485738495837, result: "success")
      @m3_tr = @m3_inv.transactions.create!(credit_card_number: 4039485738495837, result: "success")
      @m4_tr = @m4_inv.transactions.create!(credit_card_number: 4039485738495837, result: "success")
      @m5_tr = @m5_inv.transactions.create!(credit_card_number: 4039485738495837, result: "success")
      @m6_tr2 = @m6_inv2.transactions.create!(credit_card_number: 4039485738495837, result: "failed")
    end

    it "returns top 5 merchants by revenue" do
      expect(Merchant.top_five_merchants).to eq([@merch_1, @merch_5, @merch_3, @merch_4, @merch_2])
    end

    it "sort the enabled merchant" do
      expect(Merchant.enabled).to eq([@merch_2, @merch_4])
    end
    it "sort the disabled merchant" do
      expect(Merchant.disabled).to eq([@merch_1, @merch_3, @merch_5, @merch_6])
    end
  end

  describe "instance methods" do
    it "returns top 5 customers by number of successful transactions" do
      expect(@merch_1.top_5_customers).to eq([@cust_7, @cust_1, @cust_2, @cust_4, @cust_3])

      expect(@merch_1.top_5_customers.first.successful_transactions).to eq(12)
    end

    it "returns top 5 items by total revenue" do
      expect(@merch_1.top_five_items).to eq([@item_4, @item_1, @item_3, @item_2, @item_6])

      expect(@merch_1.top_five_items).not_to include(@item_5)
    end

    it "#items_ready_to_ship returns all items that have been ordered but not shipped" do
      merchant = Merchant.create!(name: "MerchyMcMerchFace")

      invoice = @cust_1.invoices.create!(status: :in_progress)
      other_invoice = @cust_1.invoices.create!(status: :in_progress)

      pending_item = merchant.items.create!(
        name: "Pending Item",
        description: "an item that is pending",
        unit_price: 2500
      )
      pending_invoice_item = InvoiceItem.create!(
        item_id: pending_item.id,
        invoice_id: invoice.id,
        quantity: 1,
        unit_price: pending_item.unit_price,
        status: 0
      )
      packaged_item = merchant.items.create!(
        name: "Packaged Item",
        description: "an item that has been packaged",
        unit_price: 4500
      )
      packaged_invoice_item = InvoiceItem.create!(
        item_id: packaged_item.id,
        invoice_id: invoice.id,
        quantity: 1,
        unit_price: packaged_item.unit_price,
        status: 1
      )
      shipped_item = merchant.items.create!(
        name: "Shipped Item",
        description: "an item that has been shipped",
        unit_price: 3500
      )
      shipped_invoice_item = InvoiceItem.create!(
        item_id: shipped_item.id,
        invoice_id: other_invoice.id,
        quantity: 1,
        unit_price: shipped_item.unit_price,
        status: 2
      )
      expect(merchant.items_ready_to_ship.ids).to include(packaged_invoice_item.invoice_id)
      expect(merchant.items_ready_to_ship.ids).to include(pending_invoice_item.invoice_id)
      expect(merchant.items_ready_to_ship.ids).to_not include(shipped_invoice_item.invoice_id)
    end

    it "finds top selling date for merchant" do
      expect(@merch_1.top_date).to eq("2019-04-04 00:00:00")
    end
  end
end
