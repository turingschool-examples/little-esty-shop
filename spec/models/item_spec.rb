require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status) }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many(:invoices)}
    it { should have_many(:invoices).through(:invoice_items)}
  end

  before :each do
  end

  describe 'class methods' do

  end

  describe 'instance methods' do

    it 'next to each of the 5 most popular items I see the date with the most sales for each item' do
      @walmart = Merchant.create!(name: "Wal-Mart")

      @target = Merchant.create!(name: "Target")

      @costco = Merchant.create!(name: "Costco")

      @pencil = Item.create!( name: "Pencil",
                              description: "Sharpen it and write with it.",
                              unit_price: 199,
                              merchant_id: @walmart.id)

      @marker = Item.create!( name: "Marker",
                              description: "Washable!",
                              unit_price: 159,
                              merchant_id: @walmart.id)

      @eraser = Item.create!( name: "Eraser",
                              description: "Use it to fix mistakes.",
                              unit_price: 205,
                              merchant_id: @walmart.id)

      @ruler = Item.create!( name: "Ruler",
                              description: "It measures things.",
                              unit_price: 105,
                              merchant_id: @walmart.id)

      @folder = Item.create!( name: "Folder",
                              description: "Store stuff in it.",
                              unit_price: 250,
                              merchant_id: @walmart.id)

      @raincoat = Item.create!( name: "Raincoat",
                              description: "Wear it so you don't get wet.",
                              unit_price: 5000,
                              merchant_id: @walmart.id)

      @highlighter = Item.create!( name: "Highlighter",
                              description: "Highlight things and make them yellow!",
                              unit_price: 305,
                              merchant_id: @target.id)
      blake = Customer.create!( first_name: "Blake",
                                    last_name: "Saylor")

      invoice_1 = Invoice.create!(status: 1,
                                  customer_id: blake.id)

      invoice_2 = Invoice.create!(status: 1,
                                  customer_id: blake.id)

      invoice_3 = Invoice.create!(status: 1,
                                  customer_id: blake.id)

      invoice_4 = Invoice.create!(status: 1,
                                  customer_id: blake.id)

      invoice_5 = Invoice.create!(status: 1,
                                  customer_id: blake.id)

      invoice_6 = Invoice.create!(status: 1,
                                  customer_id: blake.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 1,
                                            unit_price: 200,
                                            status: 'shipped',
                                            item_id: @pencil.id,
                                            invoice_id: invoice_1.id)

      invoice_item_2 = InvoiceItem.create!(quantity: 2,
                                            unit_price: 300,
                                            status: 'shipped',
                                            item_id: @marker.id,
                                            invoice_id: invoice_2.id)

      invoice_item_3 = InvoiceItem.create!(quantity: 3,
                                            unit_price: 400,
                                            status: 'shipped',
                                            item_id: @eraser.id,
                                            invoice_id: invoice_3.id)

      invoice_item_4 = InvoiceItem.create!(quantity: 4,
                                            unit_price: 500,
                                            status: 'shipped',
                                            item_id: @ruler.id,
                                            invoice_id: invoice_4.id)

      invoice_item_5 = InvoiceItem.create!(quantity: 5,
                                            unit_price: 600,
                                            status: 'shipped',
                                            item_id: @folder.id,
                                            invoice_id: invoice_5.id)

      invoice_item_6 = InvoiceItem.create!(quantity: 6,
                                            unit_price: 700,
                                            status: 'shipped',
                                            item_id: @raincoat.id,
                                            invoice_id: invoice_6.id)

      transaction_1 = Transaction.create!( credit_card_number: '1234',
                                            credit_card_expiration_date: 'never',
                                            result: 'success',
                                            invoice_id: invoice_1.id)

      transaction_2 = Transaction.create!( credit_card_number: '1234',
                                            credit_card_expiration_date: 'never',
                                            result: 'success',
                                            invoice_id: invoice_2.id)

      transaction_3 = Transaction.create!( credit_card_number: '1234',
                                            credit_card_expiration_date: 'never',
                                            result: 'success',
                                            invoice_id: invoice_3.id)

      transaction_4 = Transaction.create!( credit_card_number: '1234',
                                            credit_card_expiration_date: 'never',
                                            result: 'success',
                                            invoice_id: invoice_4.id)

      transaction_5 = Transaction.create!( credit_card_number: '1234',
                                            credit_card_expiration_date: 'never',
                                            result: 'success',
                                            invoice_id: invoice_5.id)

      transaction_6 = Transaction.create!( credit_card_number: '1234',
                                            credit_card_expiration_date: 'never',
                                            result: 'success',
                                            invoice_id: invoice_6.id)

      expect(@marker.best_day(@marker.id)).to eq(invoice_item_2.created_at.to_date.strftime("%m/%d/%Y"))
    end
  end
end
