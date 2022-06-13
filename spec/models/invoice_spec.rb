require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Invoice model #bulk discount instance methods' do
    before :each do
      @merchant1 = Merchant.create!(name: 'Suzy Hernandez')
      @merchant2 = Merchant.create!(name: 'Juan Lopez')
      @merchant3 = Merchant.create!(name: 'Uri BigBucks')

      @five = BulkDiscount.create!(name: 'Five', percent_discount: 0.05, quantity_threshold: 5,
                                   merchant_id: @merchant1.id)
      @ten = BulkDiscount.create!(name: 'Ten', percent_discount: 0.10, quantity_threshold: 10,
                                  merchant_id: @merchant1.id)
      @fifteen = BulkDiscount.create!(name: 'Fifteen', percent_discount: 0.15, quantity_threshold: 15,
                                      merchant_id: @merchant1.id)
      @fifty = BulkDiscount.create!(name: 'Fifty', percent_discount: 0.50, quantity_threshold: 50,
                                    merchant_id: @merchant1.id)

      @six = BulkDiscount.create!(name: 'Six', percent_discount: 0.06, quantity_threshold: 6,
                                  merchant_id: @merchant2.id)
      @eleven = BulkDiscount.create!(name: 'Eleven', percent_discount: 0.11, quantity_threshold: 11,
                                     merchant_id: @merchant2.id)
      @sixteen = BulkDiscount.create!(name: 'Sixteen', percent_discount: 0.16, quantity_threshold: 16,
                                      merchant_id: @merchant2.id)
      @fifty_one = BulkDiscount.create!(name: 'Fifty One', percent_discount: 0.51, quantity_threshold: 51,
                                        merchant_id: @merchant2.id)

      @seven = BulkDiscount.create!(name: 'Seven', percent_discount: 0.07, quantity_threshold: 7,
                                    merchant_id: @merchant3.id)
      @two = BulkDiscount.create!(name: 'Two', percent_discount: 0.02, quantity_threshold: 2,
                                  merchant_id: @merchant3.id)

      @item2 = @merchant2.items.create!(name: 'onion', description: 'red onion', unit_price: 3450, item_status: 1)
      @item6 = @merchant2.items.create!(name: 'skirt', description: 'Hoop skirt', unit_price: 2175, item_status: 1)
      @item8 = @merchant2.items.create!(name: 'socks', description: 'Cat Socks', unit_price: 934)

      @item10 = @merchant1.items.create!(name: 'onion1', description: 'white onion', unit_price: 3450, item_status: 1)
      @item13 = @merchant1.items.create!(name: 'ring1', description: 'flower ring', unit_price: 2345)
      @item14 = @merchant1.items.create!(name: 'skirt1', description: 'Top skirt', unit_price: 2175, item_status: 1)
      @item16 = @merchant1.items.create!(name: 'socks1', description: 'Dog Socks', unit_price: 934)

      @customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

      @invoice7 = Invoice.create!(status: 2, customer_id: @customer6.id)

      @invoice_item13 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice7.id, quantity: 5,
                                            unit_price: 2175, status: 2)
      @invoice_item7 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2175,
                                           status: 2)
      @invoice_item14 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice7.id, quantity: 57,
                                            unit_price: 934, status: 2)
      @invoice_item23 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice7.id, quantity: 3,
                                            unit_price: 3450, status: 2)
      @invoice_item21 = InvoiceItem.create!(item_id: @item13.id, invoice_id: @invoice7.id, quantity: 23,
                                            unit_price: 2345, status: 2)
      @invoice_item24 = InvoiceItem.create!(item_id: @item14.id, invoice_id: @invoice7.id, quantity: 6,
                                            unit_price: 2175, status: 2)
      @invoice_item22 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice7.id, quantity: 11,
                                            unit_price: 934, status: 2)

      @transaction8 = Transaction.create!(result: 1, invoice_id: @invoice7.id)
      @transaction9 = Transaction.create!(result: 0, invoice_id: @invoice7.id)
    end

    it 'return bulk discounts' do
      expect(@merchant1.discounts).to eq([@five, @ten, @fifteen, @fifty])
    end
    it 'will determine if an invoice has sucessful transactions' do
      expect(@invoice7.sucessful_transactions.count).to eq(1)
    end

    it 'will apply a discount' do
      expect(@invoice7.pre_discount_revenue).to eq('1560.72')
      expect(@invoice7.apply_discount).to eq(119_150.47)
    end

    it 'will display the discounted revenue from cents to 00.00' do
      expect(@invoice7.display_discount_revenue).to eq('1191.50')
    end
  end
end
