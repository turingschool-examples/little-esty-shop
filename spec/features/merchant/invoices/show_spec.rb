require 'rails_helper'

RSpec.describe 'The Merchant Invoice Show Page' do
  describe 'Bulk Discounts on Merchant Index Show page' do
    before :each do
      @merchant1 = Merchant.create!(name: 'Suzy Hernandez')
      @merchant2 = Merchant.create!(name: 'Juan Lopez')

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

      @item1 = @merchant2.items.create!(name: 'cheese', description: 'european cheese', unit_price: 2400,
                                        item_status: 1)
      @item2 = @merchant2.items.create!(name: 'onion', description: 'red onion', unit_price: 3450, item_status: 1)
      @item3 = @merchant2.items.create!(name: 'earing', description: 'Lotus earings', unit_price: 14_500)
      @item4 = @merchant2.items.create!(name: 'bracelet', description: 'Silver bracelet', unit_price: 76_000,
                                        item_status: 1)
      @item5 = @merchant2.items.create!(name: 'ring', description: 'lotus ring', unit_price: 2345)
      @item6 = @merchant2.items.create!(name: 'skirt', description: 'Hoop skirt', unit_price: 2175, item_status: 1)
      @item7 = @merchant2.items.create!(name: 'shirt', description: "Mike's Yellow Shirt", unit_price: 5405,
                                        item_status: 1)
      @item8 = @merchant2.items.create!(name: 'socks', description: 'Cat Socks', unit_price: 934)

      @item9 = @merchant1.items.create!(name: 'cheese1', description: 'americancheese', unit_price: 2400,
                                        item_status: 1)
      @item10 = @merchant1.items.create!(name: 'onion1', description: 'white onion', unit_price: 3450, item_status: 1)
      @item11 = @merchant1.items.create!(name: 'earing1', description: 'long earings', unit_price: 2375)
      @item12 = @merchant1.items.create!(name: 'bracelet1', description: 'pink bracelet', unit_price: 1908,
                                         item_status: 1)
      @item13 = @merchant1.items.create!(name: 'ring1', description: 'flower ring', unit_price: 2345)
      @item14 = @merchant1.items.create!(name: 'skirt1', description: 'Top skirt', unit_price: 2175, item_status: 1)
      @item15 = @merchant1.items.create!(name: 'shirt1', description: "Tz's Yellow Shirt", unit_price: 5405,
                                         item_status: 1)
      @item16 = @merchant1.items.create!(name: 'socks1', description: 'Dog Socks', unit_price: 934)

      @customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

      @invoice7 = Invoice.create!(status: 2, customer_id: @customer6.id)

      @invoice_item7 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2175,
                                           status: 2)
      @invoice_item13 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice7.id, quantity: 5,
                                            unit_price: 2175, status: 2)
      @invoice_item14 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice7.id, quantity: 57,
                                            unit_price: 934, status: 2)
      @invoice_item19 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice7.id, quantity: 1,
                                            unit_price: 76_000, status: 2)
      @invoice_item20 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice7.id, quantity: 11,
                                            unit_price: 2375, status: 2)
      @invoice_item21 = InvoiceItem.create!(item_id: @item13.id, invoice_id: @invoice7.id, quantity: 23,
                                            unit_price: 2345, status: 2)
      @invoice_item22 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice7.id, quantity: 2,
                                            unit_price: 934, status: 2)
      @invoice_item23 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice7.id, quantity: 7,
                                            unit_price: 3450, status: 2)

      @transaction8 = Transaction.create!(result: 1, invoice_id: @invoice7.id)
      @transaction8 = Transaction.create!(result: 0, invoice_id: @invoice7.id)
    end

    it 'will display the pre-discounted revenue' do
      visit merchant_invoice_path(@merchant2.id, @invoice7.id)

      within('.total_revenue') do
        expect(page).to have_content("Revenue pre-discount: $#{@invoice7.pre_discount_revenue}")
      end
    end

    it 'will display the post-discounted revenue' do
      visit merchant_invoice_path(@merchant2.id, @invoice7.id)

      within('.total_revenue') do
        expect(page).to have_content("Revenue post-discount: $#{@invoice7.display_discount_revenue}")
      end
    end

    it 'will display a link to the discount applied for each eligible item' do
      visit merchant_invoice_path(@merchant2.id, @invoice7.id)

      expect(page).to have_link('Discount applied to socks')
      expect(page).to have_link('Discount applied to cheese1')
      expect(page).to have_link('Discount applied to ring1')
      expect(page).to have_link('Discount applied to onion1')
    end
  end
end

RSpec.describe 'The Merchant Invoice Show Page' do
  before :each do
    @merchant = Merchant.create!(name: 'The Duke')
    @merchant2 = Merchant.create!(name: 'The Fluke')
    @customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @customer2 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @invoice1 = Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 0, customer_id: @customer2.id)
    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'literal goop', description: 'delicious', unit_price: '4000',
                          merchant_id: @merchant2.id)
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100,
                                         status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 2000,
                                         status: 1)
    @invoice_item3 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 500,
                                         status: 1)
  end

  it 'displays all information related to that invoice' do
    visit merchant_invoice_path(@merchant.id, @invoice1.id)

    expect(page).to have_content('Merchant Invoices Show Page')
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content(@invoice1.format_created_at(@invoice1.created_at))
    expect(page).to have_content(@invoice1.customer_name)
    expect(page).to have_no_content(@invoice2.id)
  end

  it 'displays the total revenue that will be generated from all items on the invoice' do
    visit merchant_invoice_path(@merchant.id, @invoice1.id)
    expect(page).to have_content(@invoice1.pre_discount_revenue)
    within('.total_revenue') do
      expect(page).to have_no_content(@invoice2.pre_discount_revenue)
    end
  end

  it 'displays status as a select field that can update the items status' do
    visit merchant_invoice_path(@merchant.id, @invoice1.id)
    expect(page).to have_content(@invoice_item1.status)
    expect(@invoice_item1.status).to eq('packaged')
    within("div#id-#{@invoice_item1.id}") do
      expect(page).to have_button('Update Item Status')
      select 'shipped', from: 'status'
      click_button('Update Item Status')
      @invoice_item1.reload
      expect(page).to have_content('shipped')
    end
    expect(page).to have_content('Item Status Has Been Updated!')
  end
end
