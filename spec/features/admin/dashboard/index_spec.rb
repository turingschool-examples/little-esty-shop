require 'rails_helper'

describe 'Admin Dashboard Index Page' do
  before :each do
    @merchant1 = Merchant.create!(name: "The Tornado")
    @item1 = @merchant1.items.create!(name: "SmartPants", description: "IQ + 20", unit_price: 125)
    @item2 = @merchant1.items.create!(name: "FunPans", description: "Cha + 20", unit_price: 2000)
    @item3 = @merchant1.items.create!(name: "FitPants", description: "Con + 20", unit_price: 150)
    @customer1 = Customer.create!(first_name: "Marky", last_name: "Mark" )
    @customer2 = Customer.create!(first_name: "Larky", last_name: "Lark" )
    @customer3 = Customer.create!(first_name: "Sparky", last_name: "Spark" )
    @customer4 = Customer.create!(first_name: "Farky", last_name: "Fark" )
    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice2 = @customer2.invoices.create!(status: 0)
    @invoice3 = @customer3.invoices.create!(status: 0)
    @invoice4 = @customer4.invoices.create!(status: 2)
    @invoice5 = @customer4.invoices.create!(status: 1)
    # invoice1 will test both items packaged
    @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 2, unit_price: 125, status: 0)
    @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 2, unit_price: 2000, status: 0)

    # invoice2 will test 1 item packaged, 1 item pending.
    @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item3.id, quantity: 5, unit_price: 125, status: 0)
    @invoice_item4 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item1.id, quantity: 2, unit_price: 125, status: 1)

    # invoice3 will test both packages pending
    @invoice_item5 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item2.id, quantity: 2, unit_price: 2000, status: 1)
    @invoice_item8 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item2.id, quantity: 1, unit_price: 2000, status: 1)

    #invoice 4 will test completed order with all items shipped, it should not appear
    @invoice_item6 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item3.id, quantity: 1, unit_price: 125, status: 2)
    @invoice_item7 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item2.id, quantity: 1, unit_price: 2000, status: 2)
    #invoice 5 was cancelled so it will test that canceled orders will not appear.
    @invoice_item9 = InvoiceItem.create!(invoice_id: @invoice5.id, item_id: @item2.id, quantity: 1, unit_price: 2000, status: 2)
  end

  it 'should display a header indicating the admin dashboard' do
    visit '/admin'
    expect(page).to have_content('Admin Dashboard')
  end

  it 'should have links to merchants and invoices index' do
    visit '/admin'
    click_button "View Invoices"

    expect(current_path).to eq("/admin/invoices")

    visit '/admin'
    click_button "View Merchants"

    expect(current_path).to eq("/admin/merchants")
  end

  it "lists the invoices that are incomplete " do
    visit '/admin'

    save_and_open_page
    #binding.pry
    expect(page).to have_link("Invoice ID: #{@invoice1.id}")
    expect(page).to have_link("Invoice ID: #{@invoice2.id}")
    expect(page).to have_link("Invoice ID: #{@invoice3.id}")
    expect(page).to_not have_content("Invoice ID: #{@invoice4.id}")
    expect(page).to_not have_content("Invoice ID: #{@invoice5.id}")
  end
  it "has links on Invoices that go to show pages." do
    visit '/admin'
    #save_and_open_page
    #binding.pry
    click_link("Invoice ID: #{@invoice1.id}")
    expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
  end
end
