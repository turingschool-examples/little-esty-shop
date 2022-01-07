require 'rails_helper'
# require 'date'

RSpec.describe "Merchant Dashboard Show Page" do
  
  before(:each) do
    @merch_1 = Merchant.create!(name: "Shop Here")

    @item_1 = Item.create!(name:"jumprope", description:"Pink and sparkly.", unit_price:600, merchant_id:"#{@merch_1.id}")
    
    @cust_1 = Customer.create!(first_name:"Hannah", last_name:"Warner")
    @cust_2 = Customer.create!(first_name:"Kimmy", last_name:"Gibbler") 
    @cust_3 = Customer.create!(first_name:"Bob", last_name:"Sagget")
    @cust_4 = Customer.create!(first_name:"Uncle", last_name:"Dave")
    @cust_5 = Customer.create!(first_name:"Uncle", last_name:"Jessie")
    @cust_6 = Customer.create!(first_name:"DJ", last_name:"Tanner")

    @invoice_1 = Invoice.create!(customer_id:"#{@cust_2.id}", status:1)
    @invoice_2 = Invoice.create!(customer_id:"#{@cust_3.id}", status:1)
    @invoice_3 = Invoice.create!(customer_id:"#{@cust_4.id}", status:1)
    @invoice_4 = Invoice.create!(customer_id:"#{@cust_5.id}", status:1)
    @invoice_5 = Invoice.create!(customer_id:"#{@cust_6.id}", status:1)
    
    @invoice_item_1 = InvoiceItem.create!(invoice_id:"#{@invoice_1.id}", item_id:"#{@item_1.id}", status: 1, quantity:1, unit_price:600, created_at: "2022-01-06 01:45:03", updated_at: "2022-01-06 01:45:03")
    @invoice_item_2 = InvoiceItem.create!(invoice_id:"#{@invoice_2.id}", item_id:"#{@item_1.id}", status: 1, quantity:1, unit_price:600, created_at: "2022-01-06 01:45:03", updated_at: "2022-01-06 01:45:03")
    @invoice_item_3 = InvoiceItem.create!(invoice_id:"#{@invoice_3.id}", item_id:"#{@item_1.id}", status: 2, quantity:1, unit_price:600)
    @invoice_item_4 = InvoiceItem.create!(invoice_id:"#{@invoice_4.id}", item_id:"#{@item_1.id}", status: 2, quantity:1, unit_price:600)
    @invoice_item_5 = InvoiceItem.create!(invoice_id:"#{@invoice_5.id}", item_id:"#{@item_1.id}", status: 2, quantity:1, unit_price:600)

  end
  
  it 'shows merchant name' do
    @merch_1 = Merchant.create!(name: "Shop Here")

    visit "/merchants/#{@merch_1.id}/dashboard"

    within ".merchant" do
      expect(page).to have_content("Merchant Name: #{@merch_1.name}")
    end
  end

  it "links to items index" do
    @merch_1 = Merchant.create!(name: "Shop Here")
    visit "/merchants/#{@merch_1.id}/dashboard"

    expect(page).to have_content("Items Index")
    click_link "Items Index"
    expect(current_path).to eq("/merchants/#{@merch_1.id}/items")
  end

  it "links to invoices index" do
    @merch_1 = Merchant.create!(name: "Shop Here")
    visit "/merchants/#{@merch_1.id}/dashboard"

    expect(page).to have_content("Invoices Index")
    click_link "Invoices Index"
    expect(current_path).to eq("/merchants/#{@merch_1.id}/invoices")
  end

  it "has 'Items Ready to Ship' with items, date invoice created, date" do 
    
    # When I visit my merchant dashboard
    # In the section for "Items Ready to Ship",
    # Next to each Item name I see the date that the invoice was created
    # And I see the date formatted like "Monday, July 18, 2019"
    # And I see that the list is ordered from oldest to newest

    visit "/merchants/#{@merch_1.id}/dashboard"
    
    within(".items-ready-to-ship") do 
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content("Invoice No. #{@invoice_1.id} Created: #{@invoice_1.created_at.strftime("%A %B %m %Y")}")

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content("Invoice No. #{@invoice_2.id} Created: #{@invoice_2.created_at.strftime("%A %B %m %Y")}")
    end
  end
    
  it "has items ordered from oldest to newest" do 
    visit "/merchants/#{@merch_1.id}/dashboard"
    
    expect("#{@invoice_1.id}").to appear_before("#{@invoice_2.id}")
  end

  xit "has top 5 favorite customers with most transaction activity with this merchant" do 
    
    visit "/merchants/#{@merch_1.id}/dashboard"
    
    expect(page).to have_content("Kimmy Gibbler | Successful Transactions: 1")
    expect(page).to have_content("Bob Sagget | Successful Transactions: 1")
    expect(page).to have_content("Uncle Dave | Successful Transactions: 1")
    expect(page).to have_content("Uncle Jessie | Successful Transactions: 1")
    expect(page).to have_content("DJ Tanner | Successful Transactions: 1")
  end
  
    
end
