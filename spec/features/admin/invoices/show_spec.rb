require 'rails_helper'

RSpec.describe 'Admin Invoices Show Page' do
  before :each do
    Faker::UniqueGenerator.clear 
    @merchant_1 = Merchant.create!(name: Faker::Company.unique.name)
    @merchant_2 = Merchant.create!(name: Faker::Company.unique.name)
    
    @customer_1 = Customer.create!(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name)
    
    @item_1 = Item.create!( name: Faker::Commerce.unique.product_name, 
                            description: 'Our first test item', 
                            unit_price: rand(100..10000), 
                            merchant_id: @merchant_1.id)

    @item_2 = Item.create!( name: Faker::Commerce.unique.product_name, 
                            description: 'Our second test item', 
                            unit_price: rand(100..10000), 
                            merchant_id: @merchant_1.id)

    @item_3 = Item.create!( name: Faker::Commerce.unique.product_name, 
                            description: 'Our third test item', 
                            unit_price: rand(100..10000), 
                            merchant_id: @merchant_2.id)

    @invoice_1 = Invoice.create!( status: 'completed', 
                                  customer_id: @customer_1.id)
    @invoice_1.id = 30
    @invoice_1.save!

    @invoice_2 = Invoice.create!( status: 'cancelled', 
                                  customer_id: @customer_1.id)
    @invoice_2.id = 20
    @invoice_2.save!
    
    @invoice_3 = Invoice.create!( status: 'in progress', 
                                  customer_id: @customer_1.id)
    @invoice_3.id = 40
    @invoice_3.save!

    @invoice_item_1 = InvoiceItem.create!(quantity: rand(1..10), 
                                          unit_price: 5000, 
                                          status: 'shipped', 
                                          item_id: @item_1.id, 
                                          invoice_id: @invoice_1.id)

    @invoice_item_2 = InvoiceItem.create!(quantity: rand(1..10), 
                                          unit_price: 10000, 
                                          status: 'shipped', 
                                          item_id: @item_2.id, 
                                          invoice_id: @invoice_1.id)

    @invoice_item_3 = InvoiceItem.create!(quantity: rand(1..10), 
                                          unit_price: 15000, 
                                          status: 'shipped', 
                                          item_id: @item_1.id, 
                                          invoice_id: @invoice_2.id)

    @invoice_item_4 = InvoiceItem.create!(quantity: rand(1..10), 
                                          unit_price: 25000, 
                                          status: 'shipped', 
                                          item_id: @item_3.id, 
                                          invoice_id: @invoice_3.id)
  end
  
  # User Story 33
  # Admin Invoice Show Page

  # As an admin,
  # When I visit an admin invoice show page
  # Then I see information related to that invoice including:
  # - Invoice id
  # - Invoice status
  # - Invoice created_at date in the format "Monday, July 18, 2019"
  # - Customer first and last name
  it 'shows all attributes related to an invoice' do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status.titlecase)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@invoice_1.customer.first_name.titlecase)
    expect(page).to have_content(@invoice_1.customer.last_name.titlecase)
  end

  # User Story 34
  # Admin Invoice Show Page: Invoice Item Information

  # As an admin
  # When I visit an admin invoice show page
  # Then I see all of the items on the invoice including:

  # Item name
  # The quantity of the item ordered
  # The price the Item sold for
  # The Invoice Item status 
  it 'shows information for all of the invoice items on an invoice' do
    visit "/admin/invoices/#{@invoice_1.id}"

    within '#invoice-item-details' do
      within "#invoice-item-#{@invoice_item_1.id}" do
        expect(page).to have_content(@invoice_item_1.item.name)
        expect(page).to have_content(@invoice_item_1.quantity)
        expect(page).to have_content('$50.00')
        expect(page).to have_content(@invoice_item_1.status.titlecase)
      end

      within "#invoice-item-#{@invoice_item_2.id}" do
        expect(page).to have_content(@invoice_item_2.item.name)
        expect(page).to have_content(@invoice_item_2.quantity)
        expect(page).to have_content('$100.00')
        expect(page).to have_content(@invoice_item_2.status.titlecase)
      end

      expect(page).to_not have_content(@invoice_item_4.item.name)
    end
  end
end

