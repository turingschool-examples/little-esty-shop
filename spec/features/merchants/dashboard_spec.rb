require 'rails_helper'

RSpec.describe "merchant dashboard", type: :feature do
  before :each do
    @merchant_1 = Merchant.create(name: "Schroeder-Jerde" )
    @merchant_2 = Merchant.create(name: "Klein, Rempel and Jones")

    @item_1 = @merchant_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
      @item_2 = @merchant_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)
      @item_3 = @merchant_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)
      @item_4 = @merchant_2.items.create!(name: "Pant", description: "pants built for people", unit_price: 50000)
  
      @cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
      @cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")
  
      @invoice_1 = @cust_1.invoices.create!(status: 1)
      @invoice_2 = @cust_1.invoices.create!(status: 1)
      @invoice_3 = @cust_1.invoices.create!(status: 1)
      @invoice_4 = @cust_2.invoices.create!(status: 1)
      @invoice_5 = @cust_2.invoices.create!(status: 1)
      @invoice_6 = @cust_2.invoices.create!(status: 1)
  
      @ii_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_1.unit_price, status: 0)
      @ii_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: @item_1.unit_price, status: 1)
      @ii_3 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: @item_2.unit_price, status: 2)
      @ii_4 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: @item_3.unit_price, status: 2)
      @ii_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: @item_1.unit_price, status: 1)
      @ii_6 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: @item_2.unit_price, status: 1)
      @ii_7 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: @item_4.unit_price, status: 1)
  end

  it "shows name of merchant" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content("Schroeder-Jerde")
    expect(page).to_not have_content("Klein, Rempel and Jones")
  end

  it "has links to merchant items index and merchant invoices index" do
    visit "/merchants/#{@merchant_1.id}/dashboard"
    
    expect(page).to have_link("My Items", href: "/merchants/#{@merchant_1.id}/items")
    expect(page).to have_link("My Invoices", href: "/merchants/#{@merchant_1.id}/invoices")
    expect(page).to_not have_link("My Items", href: "/merchants/#{@merchant_2.id}/items")
    expect(page).to_not have_link("My Invoices", href: "/merchants/#{@merchant_2.id}/invoices")
  end

  it "shows list of items ready to ship with their invoice id" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content("Items Ready To Ship")
    within("#item-0") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_1.id)
      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@invoice_2.id)
    end
    within("#item-1") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@invoice_1.id)
    end
    within("#item-2") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_4.id)
      expect(page).to_not have_content(@item_4.name)
      expect(page).to_not have_content(@invoice_1.id)
    end
    within("#item-2") do
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@invoice_4.id)
      expect(page).to_not have_content(@item_4.name)
      expect(page).to_not have_content(@invoice_2.id)
    end
  end

end
