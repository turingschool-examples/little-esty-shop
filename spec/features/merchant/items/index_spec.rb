require 'rails_helper'

RSpec.describe 'Merchants Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Ana Maria')
    @merchant_2 = Merchant.create!(name: 'Juan Lopez')
    @merchant_3 = Merchant.create!(name: 'Jamie Fergerson')
    @item_1 = @merchant_1.items.create!(name: 'cheese', description: 'european cheese', unit_price: 2400,
                                        item_status: 1)
    @item_2 = @merchant_1.items.create!(name: 'onion', description: 'red onion', unit_price: 3450, item_status: 1)
    @item_3 = @merchant_2.items.create!(name: 'earing', description: 'Lotus earings', unit_price: 14_500)
    @item_4 = @merchant_2.items.create!(name: 'bracelet', description: 'Silver bracelet', unit_price: 76_000,
                                        item_status: 1)
    @item_5 = @merchant_2.items.create!(name: 'ring', description: 'lotus ring', unit_price: 2345)
    @item_6 = @merchant_3.items.create!(name: 'skirt', description: 'Hoop skirt', unit_price: 2175, item_status: 1)
    @item_7 = @merchant_3.items.create!(name: 'shirt', description: "Mike's Yellow Shirt", unit_price: 5405,
                                        item_status: 1)
    @item_8 = @merchant_3.items.create!(name: 'socks', description: 'Cat Socks', unit_price: 934)
  end

  describe 'Merchant Items show page'
  it 'has an index with  2 sections- 1 Enabled, 1 Disabled' do
    visit "/merchants/#{@merchant_2.id}/items"

    within('#enabled_items-0') do
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_4.description)
      expect(page).to have_content(@item_4.display_price)
      expect(page).to have_button("Disable #{@item_4.name}")
    end

    within('#disabled_items-0') do
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_3.description)
      expect(page).to have_content(@item_3.display_price)
      expect(page).to have_button("Enable #{@item_3.name}")
    end

    within('#disabled_items-1') do
      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_5.description)
      expect(page).to have_content(@item_5.display_price)
      expect(page).to have_button("Enable #{@item_5.name}")
    end
  end

  it "You can click on the button to change an item's status between enabled/ disabled" do
    visit "/merchants/#{@merchant_2.id}/items"

    within('#disabled_items-1') do
      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_5.description)
      expect(page).to have_content(@item_5.display_price)
      expect(page).to have_button("Enable #{@item_5.name}")
    end

    click_button "Enable #{@item_5.name}"

    within('#enabled_items-1') do
      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_5.description)
      expect(page).to have_content(@item_5.display_price)
      expect(page).to have_button("Disable #{@item_5.name}")
    end
  end
end

RSpec.describe 'Merchants Index' do
  describe 'index page shows Merchant Top 5 Items' do
    before :each do
      @merchant2 = Merchant.create!(name: 'Juan Lopez')

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

      @customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
      @customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
      @customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
      @customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
      @customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
      @customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

      @invoice1 = Invoice.create!(status: 2, customer_id: @customer1.id)
      @invoice2 = Invoice.create!(status: 2, customer_id: @customer1.id)
      @invoice3 = Invoice.create!(status: 2, customer_id: @customer2.id)
      @invoice4 = Invoice.create!(status: 2, customer_id: @customer3.id)
      @invoice5 = Invoice.create!(status: 2, customer_id: @customer4.id)
      @invoice6 = Invoice.create!(status: 2, customer_id: @customer5.id)
      @invoice7 = Invoice.create!(status: 2, customer_id: @customer6.id)

      @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 2400,
                                           status: 1)
      @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 3450,
                                           status: 0)
      @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 14_500,
                                           status: 2)
      @invoice_item4 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 5405,
                                           status: 2)
      @invoice_item5 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice5.id, quantity: 1, unit_price: 14_500,
                                           status: 2)
      @invoice_item6 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice6.id, quantity: 1, unit_price: 76_000,
                                           status: 2)
      @invoice_item7 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2175,
                                           status: 2)
      @invoice_item8 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 934,
                                           status: 2)
      @invoice_item9 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 3450,
                                           status: 2)
      @invoice_item10 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 76_000,
                                            status: 2)
      @invoice_item11 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 2400,
                                            status: 2)
      @invoice_item12 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice5.id, quantity: 3, unit_price: 2345,
                                            status: 2)
      @invoice_item13 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 5, unit_price: 2175,
                                            status: 2)
      @invoice_item14 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice7.id, quantity: 7, unit_price: 934,
                                            status: 2)
      @invoice_item15 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 2, unit_price: 2400,
                                            status: 2)
      @invoice_item16 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 5405,
                                            status: 2)
      @invoice_item17 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 2175,
                                            status: 2)
      @invoice_item18 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 2345,
                                            status: 2)
      @invoice_item19 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 1, unit_price: 76_000,
                                            status: 2)
      @invoice_item20 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 5405,
                                            status: 2)

      @transaction1 = Transaction.create!(result: 0, invoice_id: @invoice1.id)
      @transaction2 = Transaction.create!(result: 0, invoice_id: @invoice2.id)
      @transaction3 = Transaction.create!(result: 0, invoice_id: @invoice3.id)
      @transaction4 = Transaction.create!(result: 1, invoice_id: @invoice3.id)
      @transaction5 = Transaction.create!(result: 0, invoice_id: @invoice4.id)
      @transaction6 = Transaction.create!(result: 0, invoice_id: @invoice5.id)
      @transaction7 = Transaction.create!(result: 0, invoice_id: @invoice6.id)
      @transaction8 = Transaction.create!(result: 1, invoice_id: @invoice7.id)
    end

    it "will list a Merchant's top 5 items with the name and renevue generated" do
      visit "/merchants/#{@merchant2.id}/items"

      expect(page).to have_content('Top Items')

      within('#top_items-0') do
        expect(page).to have_content(@item4.name)
        expect(page).to have_link(@item4.name)
        expect(page).to have_content(@item4.display_price)
        expect(page).to have_content("Top selling date for #{@item4.name} was #{@item4.item_best_day}")
      end

      within('#top_items-1') do
        expect(page).to have_content(@item3.name)
        expect(page).to have_link(@item3.name)
        expect(page).to have_content(@item3.display_price)
        expect(page).to have_content("Top selling date for #{@item3.name} was #{@item3.item_best_day}")
      end

      within('#top_items-2') do
        expect(page).to have_content(@item7.name)
        expect(page).to have_link(@item7.name)
        expect(page).to have_content(@item7.display_price)
        expect(page).to have_content("Top selling date for #{@item7.name} was #{@item7.item_best_day}")
      end

      within('#top_items-2') do
        expect(page).to have_content(@item1.name)
        expect(page).to have_link(@item1.name)
        expect(page).to have_content(@item1.display_price)
        expect(page).to have_content("Top selling date for #{@item1.name} was #{@item1.item_best_day}")
      end

      within('#top_items-4') do
        expect(page).to have_content(@item2.name)
        expect(page).to have_link(@item2.name)
        expect(page).to have_content(@item2.display_price)
        expect(page).to have_content("Top selling date for #{@item2.name} was #{@item2.item_best_day}")
      end
    end
  end
end
