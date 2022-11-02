require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "Relationships" do
    it { should have_many(:items) }
  end

  before(:each) do
    @merchant_1 = Merchant.create!(name: "Dave")
    @merchant_2 = Merchant.create!(name: "Kevin")

    @merchant_1_item_1 = @merchant_1.items.create!(name: "Pencil", description: "Writing implement", unit_price: 1)
    @merchant_2_item_1 = @merchant_2.items.create!(name: "Mechanical Pencil", description: "Writing implement", unit_price: 2)

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Jones")
    @customer_2 = Customer.create!(first_name: "Sarag", last_name: "Smith")

    @customer_1_invoice_1 = @customer_1.invoices.create!(status: 2)
    @customer_1_invoice_2 = @customer_1.invoices.create!(status: 2)

    @customer_2_invoice_1 = @customer_2.invoices.create!(status: 2)
    @customer_2_invoice_2 = @customer_2.invoices.create!(status: 2)

    @customer_1_invoice_1_item_1_pachaged = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 0)
    @customer_1_invoice_1_item_1_shipped = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
    @customer_1_invoice_2_item_1_merchant_2 = InvoiceItem.create!(invoice: @customer_1_invoice_2, item: @merchant_2_item_1, quantity: 1, unit_price: 4, status: 0)
    @customer_2_invoice_1_item_1_packaged = InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 0)
  end

  describe "instance methods" do
    describe ".enabled_items" do
      it "returns a collection of the enabled items for the merchant instance" do
        merchant = Merchant.create!(name: "Practical Magic Shop")
        book = merchant.items.create!(name: "Book of the dead", description: "book of necromamcy spells", unit_price: 4)
        candle = merchant.items.create!(name: "Candle of life", description: "candle that gifts everlasting life", unit_price: 15)
        potion = merchant.items.create!(name: "Love potion", description: "One serving size of true love potion", unit_price: 10, status: 0)

        expect(merchant.enabled_items).to eq([potion])

        coffee = merchant.items.create!(name: "Coffee mug", description: "Its a mug", unit_price: 1, status: 0)

        expect(merchant.enabled_items).to eq([potion, coffee])
      end
    end

    describe '.invoice_items_to_ship' do
      describe 'returns an array of invoice_items' do
        it 'where invoice_item is "packaged" (0)' do
          expect(@merchant_1.invoice_items_to_ship).to eq([@customer_1_invoice_1_item_1_pachaged, @customer_2_invoice_1_item_1_packaged])
        end
        it 'ordered by invoice created_at, NOT invoice_item created_at' do
          customer_2_invoice_1 = InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 3, status: 0)

          expect(@merchant_1.invoice_items_to_ship).to eq([@customer_1_invoice_1_item_1_pachaged, customer_2_invoice_1, @customer_2_invoice_1_item_1_packaged])
        end
      end
    end

    describe ".disabled_items" do
      it "returns a collection of the disabled items for the merchant instance" do
        merchant = Merchant.create!(name: "Practical Magic Shop")
        book = merchant.items.create!(name: "Book of the dead", description: "book of necromamcy spells", unit_price: 4)
        candle = merchant.items.create!(name: "Candle of life", description: "candle that gifts everlasting life", unit_price: 15)
        potion = merchant.items.create!(name: "Love potion", description: "One serving size of true love potion", unit_price: 10, status: 0)

        expect(merchant.disabled_items).to eq([book, candle])

        coffee = merchant.items.create!(name: "Coffee mug", description: "Its a mug", unit_price: 1)

        expect(merchant.disabled_items).to eq([book, candle, coffee])
      end
    end

    describe "#top_five_items" do 
      it "returns a collection of items, including their total revenue, of the top five items for that merchant" do 
        merchant = Merchant.create!(name: "Practical Magic Shop")

        book = merchant.items.create!(name: "Book of the dead", description: "book of necromancy spells", unit_price: 4)
        candle = merchant.items.create!(name: "Candle of life", description: "candle that gifts everlasting life", unit_price: 15)
        potion = merchant.items.create!(name: "Love potion", description: "One serving size of true love potion", unit_price: 10)
        scroll = merchant.items.create!(name: "Scroll of healing", description: "A scroll which when read aloud, heals your wounds.", unit_price: 9)
        bone = merchant.items.create!(name: "Bird bones", description: "Complete (not intact) skeleton of crow. For use as spell components.", unit_price: 2)
        wand = merchant.items.create!(name: "Willow birch wand", description: "Newly made 12-inch willow birch wand.", unit_price: 3)
        the_sixth_item = merchant.items.create(name: "Sixth", description: "Another item", unit_price: 1)
    
        customer = Customer.create!(first_name: "Gandalf", last_name: "Thegrey")
    
        invoice_1 = customer.invoices.create!(status: 1)
        invoice_2 = customer.invoices.create!(status: 1)
        invoice_3 = customer.invoices.create!(status: 1)
    
        InvoiceItem.create!(invoice: invoice_1, item: book, quantity: 2, unit_price: 4, status: 2)
        InvoiceItem.create!(invoice: invoice_1, item: the_sixth_item, quantity: 1, unit_price: 1, status: 2)
        InvoiceItem.create!(invoice: invoice_1, item: candle, quantity: 2, unit_price: 15, status: 2)
        InvoiceItem.create!(invoice: invoice_2, item: potion, quantity: 2, unit_price: 10, status: 2)
        InvoiceItem.create!(invoice: invoice_2, item: scroll, quantity: 2, unit_price: 9, status: 2)
        InvoiceItem.create!(invoice: invoice_2, item: bone, quantity: 1, unit_price: 2, status: 2)
        InvoiceItem.create!(invoice: invoice_3, item: wand, quantity: 1, unit_price: 3, status: 0)
        InvoiceItem.create!(invoice: invoice_3, item: scroll, quantity: 6, unit_price: 9, status: 0)
    
        invoice_1.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "success")
        invoice_1.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "failed")
        invoice_2.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "success")
        invoice_3.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "failed")

        expect(merchant.top_five_items).to eq([candle, potion, scroll, book, bone])
        expect(merchant.top_five_items[0].total_revenue).to eq(30)
        expect(merchant.top_five_items[1].total_revenue).to eq(20)
        expect(merchant.top_five_items[2].total_revenue).to eq(18)
        expect(merchant.top_five_items[3].total_revenue).to eq(8)
        expect(merchant.top_five_items[4].total_revenue).to eq(2)
      end
    end
  end
end