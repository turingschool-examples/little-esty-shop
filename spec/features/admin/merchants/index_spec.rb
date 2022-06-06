require "rails_helper"

RSpec.describe 'Admin Merchant Index Page' do
  before :each do
    @billman = Merchant.create!(name: "Billman")
    @jacobs = Merchant.create!(name: "Jacobs")
  end

  it "shows the name of each merchant" do
    visit admin_merchants_path
    expect(page).to have_content(@jacobs.name)
    expect(page).to have_content(@billman.name)
  end

  it "has a link to show page for each merchant name" do
    visit admin_merchants_path
    click_link ("#{@jacobs.name}")
    expect(current_path).to eq(admin_merchant_path(@jacobs.id))
  end

  it "can update merchant status to enabled/disabled" do
    visit admin_merchants_path
    expect(page).to_not have_button("Enable")
    expect(page).to have_button("Disable", count: 2)

    click_button 'Disable', match: :first

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_button("Disable", count: 1)
    expect(page).to have_button("Enable", count: 1)
  end

  it "links to a new page for creating a new merchant " do
    visit admin_merchants_path
    click_link "Create New Merchant"
    expect(current_path).to eq(new_admin_merchant_path)
  end

  it "shows top 5 merchants by total revenue" do
    @burke = Merchant.create!(name: "Burke")
    @hall = Merchant.create!(name: "Hall")
    @chris = Merchant.create!(name: "Chris")
    @mikedao = Merchant.create!(name: "Mike Dao")

    @brenda = Customer.create!(first_name: "Brenda", last_name: "Bhoddavista")

    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001)
    @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002)
    @stuff1 = @jacobs.items.create!(name: "macbook", description: "Moody", unit_price: 3002)
    @stuff2 = @burke.items.create!(name: "stuff2", description: "Moody", unit_price: 4002)
    @stuff3 = @hall.items.create!(name: "stuff4", description: "Moody", unit_price: 5002)
    @stuff4 = @chris.items.create!(name: "stuff6", description: "Moody", unit_price: 6002)
    @stuff5 = @mikedao.items.create!(name: "stuff8", description: "Moody", unit_price: 7002)

    @invoice1 = @brenda.invoices.create!(status: "In Progress")
    @invoice2 = @brenda.invoices.create!(status: "Completed")
    @invoice3 = @brenda.invoices.create!(status: "Completed")
    @invoice4 = @brenda.invoices.create!(status: "Completed")

    @transaction1 = @invoice1.transactions.create!(credit_card_number: 4654405418249632, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction2 = @invoice2.transactions.create!(credit_card_number: 4654405418249632, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction3 = @invoice3.transactions.create!(credit_card_number: 4654405418249632, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction4 = @invoice4.transactions.create!(credit_card_number: 4654405418249632, result: "success", created_at: Time.now, updated_at: Time.now)

    @order1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice1.id)
    @order2 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Packaged", invoice_id: @invoice1.id)
    @order3 = @mood.invoice_items.create!(quantity: 3, unit_price: 2002, status: "Shipped", invoice_id: @invoice2.id)
    InvoiceItem.create!(item_id: @stuff1.id, invoice_id: @invoice2.id, quantity: 1, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @stuff2.id, invoice_id: @invoice3.id, quantity: 2, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @stuff3.id, invoice_id: @invoice4.id, quantity: 3, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @stuff4.id, invoice_id: @invoice3.id, quantity: 4, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @stuff5.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 1000, status: "Shipped")

    visit admin_merchants_path
    within '#top5' do
      save_and_open_page
      expect(@billman.name).to appear_before(@mikedao.name)
      expect(@mikedao.name).to appear_before(@chris.name)
      expect(@chris.name).to appear_before(@hall.name)
      expect(@hall.name).to appear_before(@burke.name)

      expect(page).to_not have_content(@jacobs.name)
    end
  end
end
