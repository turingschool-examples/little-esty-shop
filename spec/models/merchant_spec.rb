require "rails_helper"


RSpec.describe Merchant, type: :model do
  describe "Relationships" do
    it { should have_many(:items) }
    it { should have_many(:discounts) }
  end

  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_1_item_1 = create(:item, merchant: @merchant_1, status: 0)
    @merchant_1_item_2 = create(:item, merchant: @merchant_1, status: 0)
    @merchant_1_item_3 = create(:item, merchant: @merchant_1, status: 1)
    @merchant_1_item_4 = create(:item, merchant: @merchant_1, status: 1)
    @merchant_1_item_5 = create(:item, merchant: @merchant_1, status: 1)
    @merchant_1_item_6 = create(:item, merchant: @merchant_1, status: 1)

    @merchant_2 = create(:merchant)
    @merchant_2_item_1 = create(:item, merchant: @merchant_2, status: 0)
    @merchant_2_item_2 = create(:item, merchant: @merchant_2, status: 1)

    @march_third = DateTime.new(2022, 3, 3, 6, 2, 3)
    @customer_1 = create(:customer)
    @customer_1_invoice_1 = @customer_1.invoices.create!(created_at: @march_third, status: 2)
    @customer_1_invoice_2 = @customer_1.invoices.create!(status: 2)

    @customer_2 = create(:customer)
    @customer_2_invoice_1 = @customer_2.invoices.create!(status: 2)
    @customer_2_invoice_2 = @customer_2.invoices.create!(status: 2)

    @customer_1_invoice_1_item_1_packaged = create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 1, status: 0)
    @customer_1_invoice_1_item_1_shipped = create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 1, status: 2)
    @customer_1_invoice_2_item_1_merchant_2 = create(:invoice_item, invoice: @customer_1_invoice_2, item: @merchant_2_item_1, status: 0)
    @customer_2_invoice_1_item_1_packaged = create(:invoice_item, invoice: @customer_2_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 1, status: 0)
  end

  describe "Instance Methods" do
    describe "#enabled_items" do
      it "returns a collection of the enabled items for the merchant instance" do
        expect(@merchant_1.enabled_items.to_a).to eq([@merchant_1_item_1, @merchant_1_item_2])
      end
    end

    describe "#invoice_items_to_ship" do
      describe "returns an array of invoice_items" do
        it "where invoice_item is \"packaged\" (0)" do
          expect(@merchant_1.invoice_items_to_ship).to eq([@customer_1_invoice_1_item_1_packaged, @customer_2_invoice_1_item_1_packaged])
        end

        it "ordered by invoice created_at, NOT invoice_item created_at" do
          customer_1_invoice_1 = create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_1, status: 0)
          expect(@merchant_1.invoice_items_to_ship).to eq([@customer_1_invoice_1_item_1_packaged, customer_1_invoice_1, @customer_2_invoice_1_item_1_packaged])
        end
      end
    end

    describe "#disabled_items" do
      it "returns an array of disabled items for that merchant instance" do
        expect(@merchant_1.disabled_items).to eq([@merchant_1_item_3, @merchant_1_item_4, @merchant_1_item_5, @merchant_1_item_6])
      end
    end

    describe 'Top revenue items and day' do
      before(:each) do
        10.times {create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 10, unit_price: 10, status: 0)}
        9.times {create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_2, quantity: 10, unit_price: 10,status: 0)}
        8.times {create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_3, quantity: 10, unit_price: 10,status: 0)}
        7.times {create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_4, quantity: 10, unit_price: 10,status: 0)}
        6.times {create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_5, quantity: 10, unit_price: 10,status: 0)}
        create(:transaction, invoice: @customer_1_invoice_1, result: 'success')
      end

      describe "#top_five_items" do
        it "returns a collection of items, including their total revenue, of the top five items for that merchant" do
          expect(@merchant_1.top_five_items).to eq([@merchant_1_item_1, @merchant_1_item_2, @merchant_1_item_3, @merchant_1_item_4, @merchant_1_item_5])
          expect(@merchant_1.top_five_items[0].total_revenue).to(eq(1002))
          expect(@merchant_1.top_five_items[1].total_revenue).to(eq(900))
          expect(@merchant_1.top_five_items[2].total_revenue).to(eq(800))
          expect(@merchant_1.top_five_items[3].total_revenue).to(eq(700))
          expect(@merchant_1.top_five_items[4].total_revenue).to(eq(600))
        end

        describe "#top_day" do
          it "returns the DateTime for merchants top revenue day" do
            expect(@merchant_1.top_day).to(eq(@march_third))
          end
        end
      end
    end
  end

  describe "Class Method" do
    describe ".top_five_merchants" do
      it "can check top 5 merchants" do
        feb_third = DateTime.new(2022, 2, 3, 4, 5, 6)
        march_third = DateTime.new(2022, 3, 3, 6, 2, 3)
        april_first = DateTime.new(2022, 4, 1, 8, 9, 6)
        @merchant1 = Merchant.create!(        name: "Tokyos Tractors")
        @item1 = @merchant1.items.create!(        name: "A",         description: "Alpha",         unit_price: 1)
        @item2 = @merchant1.items.create!(        name: "B",         description: "Bravo",         unit_price: 2)
        @item3 = @merchant1.items.create!(        name: "C",         description: "Charlie",         unit_price: 3)
        @cx1 = Customer.create!(        first_name: "Tapanga",         last_name: "Toloza")
        @invoice_1 = @cx1.invoices.create!(        status: 1,         created_at: feb_third)
        @invoice_2 = @cx1.invoices.create!(        status: 1,         created_at: march_third)
        InvoiceItem.create!(        invoice: @invoice_1,         item: @item1,         quantity: 1,         unit_price: 1,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_2,         item: @item2,         quantity: 1,         unit_price: 2,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_2,         item: @item3,         quantity: 1,         unit_price: 3,         status: 2)
        @invoice_1.transactions.create!(        credit_card_number: 123456789,         credit_card_expiration_date: "07/2023",         result: "success")
        @invoice_2.transactions.create!(        credit_card_number: 123456789,         credit_card_expiration_date: "07/2023",         result: "success")
        @merchant2 = Merchant.create!(        name: "Oslos Outdoor Market")
        @item4 = @merchant2.items.create!(        name: "D",         description: "Delta",         unit_price: 4)
        @item5 = @merchant2.items.create!(        name: "E",         description: "Echo",         unit_price: 5)
        @item6 = @merchant2.items.create!(        name: "F",         description: "Fox",         unit_price: 6)
        @cx2 = Customer.create!(        first_name: "Ocsar",         last_name: "Oreily")
        @invoice_3 = @cx2.invoices.create!(        status: 1,         created_at: april_first)
        InvoiceItem.create!(        invoice: @invoice_2,         item: @item4,         quantity: 1,         unit_price: 3,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_2,         item: @item5,         quantity: 1,         unit_price: 4,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_2,         item: @item6,         quantity: 1,         unit_price: 5,         status: 2)
        @invoice_3.transactions.create!(        credit_card_number: 123456789,         credit_card_expiration_date: "07/2023",         result: "success")
        @merchant3 = Merchant.create!(        name: "Berlins Building Supply")
        @item7 = @merchant3.items.create!(        name: "G",         description: "Golf",         unit_price: 7)
        @item8 = @merchant3.items.create!(        name: "H",         description: "Hotel",         unit_price: 8)
        @item9 = @merchant3.items.create!(        name: "I",         description: "India",         unit_price: 9)
        @cx3 = Customer.create!(        first_name: "Bruce",         last_name: "Banner")
        @invoice_4 = @cx3.invoices.create!(        status: 1,         created_at: feb_third)
        @invoice_5 = @cx3.invoices.create!(        status: 1,         created_at: feb_third)
        InvoiceItem.create!(        invoice: @invoice_4,         item: @item7,         quantity: 1,         unit_price: 4,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_4,         item: @item8,         quantity: 1,         unit_price: 5,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_5,         item: @item9,         quantity: 1,         unit_price: 6,         status: 2)
        @invoice_4.transactions.create!(        credit_card_number: 123456789,         credit_card_expiration_date: "07/2023",         result: "success")
        @invoice_5.transactions.create!(        credit_card_number: 123456789,         credit_card_expiration_date: "07/2023",         result: "success")
        @merchant4 = Merchant.create!(        name: "Rios Radios")
        @item10 = @merchant4.items.create!(        name: "J",         description: "Juliet",         unit_price: 10)
        @item11 = @merchant4.items.create!(        name: "K",         description: "Kilo",         unit_price: 11)
        @item12 = @merchant4.items.create!(        name: "L",         description: "lima",         unit_price: 12)
        @cx4 = Customer.create!(        first_name: "Roy",         last_name: "Rodriguez")
        invoice_4 = @cx4.invoices.create!(        status: 1,         created_at: feb_third)
        @invoice_5 = @cx4.invoices.create!(        status: 1,         created_at: march_third)
        InvoiceItem.create!(        invoice: @invoice_4,         item: @item10,         quantity: 1,         unit_price: 7,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_5,         item: @item11,         quantity: 1,         unit_price: 8,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_5,         item: @item12,         quantity: 1,         unit_price: 9,         status: 0)
        @invoice_4.transactions.create!(        credit_card_number: 123456789,         credit_card_expiration_date: "07/2023",         result: "success")
        @invoice_5.transactions.create!(        credit_card_number: 123456789,         credit_card_expiration_date: "07/2023",         result: "success")
        @merchant5 = Merchant.create!(        name: "Moscows Mechanics")
        @item13 = @merchant5.items.create!(        name: "M",         description: "Mike",         unit_price: 13)
        @item14 = @merchant5.items.create!(        name: "N",         description: "November",         unit_price: 14)
        @item15 = @merchant5.items.create!(        name: "O",         description: "Oscar",         unit_price: 15)
        @cx5 = Customer.create!(        first_name: "Mary",         last_name: "Mccall")
        @invoice_6 = @cx3.invoices.create!(        status: 1,         created_at: march_third)
        @invoice_7 = @cx3.invoices.create!(        status: 1,         created_at: march_third)
        InvoiceItem.create!(        invoice: @invoice_6,         item: @item13,         quantity: 1,         unit_price: 10,         status: 0)
        InvoiceItem.create!(        invoice: @invoice_7,         item: @item14,         quantity: 1,         unit_price: 11,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_7,         item: @item15,         quantity: 1,         unit_price: 12,         status: 2)
        @invoice_6.transactions.create!(        credit_card_number: 123456789,         credit_card_expiration_date: "07/2023",         result: "success")
        @invoice_7.transactions.create!(        credit_card_number: 123456789,         credit_card_expiration_date: "07/2023",         result: "success")
        @merchant6 = Merchant.create!(        name: "Denver Divers")
        @item16 = @merchant6.items.create!(        name: "P",         description: "Papa",         unit_price: 16)
        @item17 = @merchant6.items.create!(        name: "Q",         description: "Quebec",         unit_price: 17)
        @item18 = @merchant6.items.create!(        name: "R",         description: "Romeo",         unit_price: 18)
        @cx6 = Customer.create!(        first_name: "David",         last_name: "Dallal")
        @invoice_8 = @cx6.invoices.create!(        status: 1,         created_at: march_third)
        InvoiceItem.create!(        invoice: @invoice_8,         item: @item16,         quantity: 2,         unit_price: 16,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_8,         item: @item17,         quantity: 1,         unit_price: 17,         status: 2)
        InvoiceItem.create!(        invoice: @invoice_8,         item: @item18,         quantity: 1,         unit_price: 18,         status: 2)
        @invoice_8.transactions.create!(        credit_card_number: 123456789,         credit_card_expiration_date: "07/2023",         result: "failed")
        expect(Merchant.top_five_merchants).to(eq([
          @merchant5,
          @merchant4,
          @merchant3,
          @merchant2,
          @merchant1,
        ]))
      end
    end

    describe ".enabled_merchants" do
      it "returns collection of enabled merchants" do
        merchant1 = Merchant.create!(        name: "Tokyos Tractors",         status: 0)
        merchant2 = Merchant.create!(        name: "Oslos Outdoor Market",         status: 1)
        merchant3 = Merchant.create!(        name: "Berlins Building Supply",         status: 0)
        merchant4 = Merchant.create!(        name: "Rios Radios",         status: 1)
        expect(Merchant.enabled_merchants).to(eq([merchant1, merchant3]))
      end
    end

    describe ".disabled_merchants" do
      it "returns collection of disabled merchants" do
        merchant1 = Merchant.create!(        name: "Tokyos Tractors",         status: 0)
        merchant2 = Merchant.create!(        name: "Oslos Outdoor Market",         status: 1)
        merchant3 = Merchant.create!(        name: "Berlins Building Supply",         status: 0)
        merchant4 = Merchant.create!(        name: "Rios Radios",         status: 1)
        expect(Merchant.disabled_merchants).to(eq([@merchant_1, @merchant_2, merchant2, merchant4]))
      end
    end

    describe ".items_by_invoice" do
      it 'returns an array of the merchants items by select invoice' do

      end
    end
  end
end
