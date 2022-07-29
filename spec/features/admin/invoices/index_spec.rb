require 'rails_helper'

RSpec.describe 'Admin Merchants Invoices Index' do
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

    InvoiceItem.create!(quantity: rand(1..10), 
                        unit_price: rand(100..10000), 
                        status: 'shipped', 
                        item_id: @item_1.id, 
                        invoice_id: @invoice_1.id)

    InvoiceItem.create!(quantity: rand(1..10), 
                        unit_price: rand(100..10000), 
                        status: 'shipped', 
                        item_id: @item_2.id, 
                        invoice_id: @invoice_1.id)

    InvoiceItem.create!(quantity: rand(1..10), 
                        unit_price: rand(100..10000), 
                        status: 'shipped', 
                        item_id: @item_1.id, 
                        invoice_id: @invoice_2.id)

    InvoiceItem.create!(quantity: rand(1..10), 
                        unit_price: rand(100..10000), 
                        status: 'shipped', 
                        item_id: @item_3.id, 
                        invoice_id: @invoice_3.id)
  end

  # User Story 32
  # Admin Invoices Index Page

  # As an admin,
  # When I visit the admin Invoices index ("/admin/invoices")
  # Then I see a list of all Invoice ids in the system
  # Each id links to the admin invoice show page
  it 'has a list of all invoice IDs in the system with links to the admin invoice show page' do
    visit "/admin/invoices"

    within '#invoices-list' do
      expect(page).to have_content("Invoice #" + @invoice_1.id.to_s)
      expect(page).to have_link("Invoice ##{@invoice_1.id}", href: "/admin/invoices/#{@invoice_1.id}")
      
      expect(page).to have_content("Invoice #" + @invoice_2.id.to_s)
      expect(page).to have_link("Invoice ##{@invoice_2.id}", href: "/admin/invoices/#{@invoice_2.id}")
      
      expect(page).to have_content("Invoice #" + @invoice_3.id.to_s)
      expect(page).to have_link("Invoice ##{@invoice_3.id}", href: "/admin/invoices/#{@invoice_3.id}")
    end

    click_link "Invoice ##{@invoice_1.id}"
    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
  end

  it 'has invoices ordered based on ascending invoice id' do
    visit "/admin/invoices"

    within '#invoices-list' do
      expect("Invoice ##{@invoice_2.id}").to appear_before("Invoice ##{@invoice_1.id}")
      expect("Invoice ##{@invoice_2.id}").to appear_before("Invoice ##{@invoice_3.id}")
      expect("Invoice ##{@invoice_1.id}").to appear_before("Invoice ##{@invoice_3.id}")
    end
  end
end