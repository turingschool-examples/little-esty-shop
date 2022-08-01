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

    @invoice_2 = Invoice.create!( status: 'cancelled', 
                                  customer_id: @customer_1.id)
    
    @invoice_3 = Invoice.create!( status: 'in progress', 
                                  customer_id: @customer_1.id)

    @invoice_item_1 = InvoiceItem.create!(quantity: 1, 
                                          unit_price: 5000, 
                                          status: 'shipped', 
                                          item_id: @item_1.id, 
                                          invoice_id: @invoice_1.id)

    @invoice_item_2 = InvoiceItem.create!(quantity: 5, 
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

    save_and_open_page

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
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
  
  # User Story 35
  # Admin Invoice Show Page: Total Revenue

  # As an admin
  # When I visit an admin invoice show page
  # Then I see the total revenue that will be generated from this invoice
  it 'shows the total revenue that will be generated for the invoice' do
    visit "/admin/invoices/#{@invoice_1.id}"

    within '#invoice-details' do
      expect(page).to have_content('$550.00')
    end
  end

  # User Story 36
  # Admin Invoice Show Page: Update Invoice Status

  # As an admin
  # When I visit an admin invoice show page
  # I see the invoice status is a select field
  # And I see that the invoice's current status is selected
  # When I click this select field,
  # Then I can select a new status for the Invoice,
  # And next to the select field I see a button to "Update Invoice Status"
  # When I click this button
  # I am taken back to the admin invoice show page
  # And I see that my Invoice's status has now been updated
  it 'has a select field for invoice status that can update the status and redirect the user' do
    visit "/admin/invoices/#{@invoice_1.id}"

    within "#invoice-details" do
      expect(page).to have_content("#{@invoice_1.status}")
      select "completed", :from => "status"
      click_on("Update Invoice Status")
      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
      expect(page).to have_content("completed")
    end
  end
end

