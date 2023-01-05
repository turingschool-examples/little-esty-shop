require 'rails_helper'

RSpec.describe 'merchant show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
    @merchant2 = Merchant.create!(name: 'Jays Foot Made Jewlery')

    @item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'darrel', description: 'Bracelet', unit_price: 40, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'don', description: 'Necklace', unit_price: 30, merchant_id: @merchant1.id)

    @item4 = Item.create!(name: 'fake', description: 'Toe Ring', unit_price: 30, merchant_id: @merchant2.id)

    @customer1 = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
    @customer2 = Customer.create!(first_name: 'William', last_name: 'Lampke')

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer1.id)

    @invoice4 = Invoice.create!(status: 1, customer_id: @customer2.id)

    @transaction1 = Transaction.create!(credit_card_number: '123456789', credit_card_expiration_date: '05/07',
                                        invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '987654321', credit_card_expiration_date: '04/07',
                                        invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(credit_card_number: '543219876', credit_card_expiration_date: '03/07',
                                        invoice_id: @invoice3.id)

    @transaction4 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                        invoice_id: @invoice4.id)

    @ii1 = InvoiceItem.create!(quantity: 5, unit_price: @item1.unit_price, item_id: @item1.id, invoice_id: @invoice1.id)
    @ii2 = InvoiceItem.create!(quantity: 5, unit_price: @item2.unit_price, item_id: @item2.id, invoice_id: @invoice2.id)
    @ii3 = InvoiceItem.create!(quantity: 5, unit_price: @item3.unit_price, item_id: @item3.id, invoice_id: @invoice3.id)

    @ii4 = InvoiceItem.create!(quantity: 5, unit_price: @item4.unit_price, item_id: @item4.id, invoice_id: @invoice4.id)
  end

  describe 'story 1' do
    #   As a merchant,
    # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
    # Then I see the name of my merchant
    it 'shows the name of the merchant' do
      visit "merchants/#{@merchant1.id}/dashboards"
      expect(page).to have_content(@merchant1.name)
    end
  end

  describe 'story 2' do
    #     As a merchant,
    # When I visit my merchant dashboard
    # Then I see link to my merchant items index (/merchants/merchant_id/items)
    # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
    it 'has a link to the merchant items index' do
      visit "merchants/#{@merchant1.id}/dashboards"

      expect(page).to have_link("#{@merchant1.name} items")
    end

    it 'has a link to the merchant invoices index' do
      visit "merchants/#{@merchant1.id}/dashboards"

      expect(page).to have_link("#{@merchant1.name} invoices")
    end
  end

  #   As a merchant
  # When I visit my merchant dashboard
  # Then I see a section for "Items Ready to Ship"
  # In that section I see a list of the names of all of my items that
  # have been ordered and have not yet been shipped,
  # And next to each Item I see the id of the invoice that ordered my item
  # And each invoice id is a link to my merchant's invoice show page
  describe 'Items Ready to Ship Section' do
    before :each do
      visit merchant_dashboards_path(@merchant1.id)
    end

    it 'has section titled Items Ready to Ship' do
      expect(page).to have_css('section#packaged')
      expect(page).to have_content('Items Ready to Ship')
    end

    it 'lists names of all ordered, unshipped items' do
      @merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')

      @item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: 'darrel', description: 'Bracelet', unit_price: 40, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: 'don', description: 'Necklace', unit_price: 30, merchant_id: @merchant1.id)

      @customer1 = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
      @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id)
      @ii1 = InvoiceItem.create!(quantity: 5, unit_price: @item1.unit_price, item_id: @item1.id, invoice_id: @invoice1.id)
      @ii2 = InvoiceItem.create!(quantity: 5, unit_price: @item2.unit_price, item_id: @item2.id, invoice_id: @invoice1.id)
      @ii3 = InvoiceItem.create!(quantity: 5, unit_price: @item3.unit_price, item_id: @item3.id, invoice_id: @invoice1.id)
      # @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id)
      
      # status pending
      # status packaged
      # @invoice3 = Invoice.create!(status: 1, customer_id: @customer1.id)
      # @invoice4 = Invoice.create!(status: 1, customer_id: @customer2.id)
      # @invoice4 = Invoice.create!(status: 1, customer_id: @customer2.id)
      # @customer2 = Customer.create!(first_name: 'William', last_name: 'Lampke')
      # @invoice4 = Invoice.create!(status: 2, customer_id: @customer2.id)
      # @ii2 = InvoiceItem.create!(quantity: 5, unit_price: @item2.unit_price, item_id: @item2.id, invoice_id: @invoice2.id)
      # @ii3 = InvoiceItem.create!(quantity: 4, unit_price: @item3.unit_price, item_id: @item3.id, invoice_id: @invoice2.id)
      # status shipped

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)



    end
    it 'lists invoice id next to item name'
    it 'links to merchants invoice show page from invoice id'
  end
end
