require 'rails_helper'

RSpec.describe "When I visit a Merchant's dashboard", type: :feature do
  before :each do
    @joe = Merchant.create!(name: "Joe Rogan")
    @customer1 = Customer.create!(first_name: "Dana", last_name: "White")
    @customer2 = Customer.create!(first_name: "John", last_name: "Singer")
    @customer3 = Customer.create!(first_name: "Jack", last_name: "Berry")
    @customer4 = Customer.create!(first_name: "Jill", last_name: "Kellogg")
    @customer5 = Customer.create!(first_name: "Jason", last_name: "Sayles")
    @item1 = @joe.items.create!(name: "Basketball", description: "Bouncy", unit_price: 20)
    @item2 = @joe.items.create!(name: "Baseball", description: "Not Bouncy", unit_price: 10)
    @item3 = @joe.items.create!(name: "Hockey Puck", description: "Not Bouncy", unit_price: 2)
    @inv1 = @customer1.invoices.create!(status: "completed")
    @inv2 = @customer2.invoices.create!(status: "completed")
    @inv3 = @customer3.invoices.create!(status: "completed")
    @inv4 = @customer4.invoices.create!(status: "completed")
    @inv5 = @customer5.invoices.create!(status: "completed")
    InvoiceItem.create!(invoice: @inv1, item: @item1, unit_price: 20, status: "packaged")
    InvoiceItem.create!(invoice: @inv2, item: @item2, unit_price: 10, status: "packaged")
    InvoiceItem.create!(invoice: @inv3, item: @item3, unit_price: 2, status: "shipped")
    InvoiceItem.create!(invoice: @inv4, item: @item1, unit_price: 2, status: "shipped")
    InvoiceItem.create!(invoice: @inv5, item: @item2, unit_price: 2, status: "shipped")
    5.times{@inv5.transactions.create!(result: "success")}
    4.times{@inv4.transactions.create!(result: "success")}
    3.times{@inv3.transactions.create!(result: "success")}
    2.times{@inv2.transactions.create!(result: "success")}
    @inv1.transactions.create!(result: "success")
  end

  scenario "I see the name of my merchant" do
    visit "/merchants/#{@joe.id}/dashboard"

    expect(page).to have_content(@joe.name)
  end

  scenario "I see a link to the merchants item and invoice indexs" do
    visit "/merchants/#{@joe.id}/dashboard"
    
    within(".navbar") do
      expect(page).to have_link("Items")
      expect(page).to have_link("Invoices")
    end
  end
# I see a section for "Items Ready to Ship"
# In that section I see a list of the names of all of my items that
# have been ordered and have not yet been shipped,
  scenario "I see items ready to ship with the corresponding 8" do
    expected_time = @inv1.created_at.strftime('%A, %b %d, %Y')
    visit "/merchants/#{@joe.id}/dashboard"

    within("#unshipped-#{@item1.name}") do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@inv1.id)
      expect(page).to have_content(expected_time)
    end
    within("#unshipped-#{@item2.name}") do
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@inv2.id)
      expect(page).to have_content(expected_time)
    end

    expect(page).to_not have_css("#unshipped-#{@item3.id}")
  end

  scenario "I see the top 5 customers and their successful transactions count" do
    successcount1 = @joe.top_five_customers[0].successful
    successcount2 = @joe.top_five_customers[1].successful
    successcount3 = @joe.top_five_customers[2].successful
    successcount4 = @joe.top_five_customers[3].successful
    successcount5 = @joe.top_five_customers[4].successful
    visit "/merchants/#{@joe.id}/dashboard"

    within("#top-five") do
      expect(page).to have_content(@customer5.first_name)
      expect(page).to have_content(@customer5.last_name)
      expect(page).to have_content(@customer4.first_name)
      expect(page).to have_content(@customer4.last_name)
      expect(page).to have_content(@customer3.first_name)
      expect(page).to have_content(@customer3.last_name)
      expect(page).to have_content(@customer2.first_name)
      expect(page).to have_content(@customer2.last_name)
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
    end
    within("#customer-#{@customer5.id}") do
      expect(page).to have_content(successcount1)
    end
    within("#customer-#{@customer4.id}") do
      expect(page).to have_content(successcount2)
    end
    within("#customer-#{@customer3.id}") do
      expect(page).to have_content(successcount3)
    end
    within("#customer-#{@customer2.id}") do
      expect(page).to have_content(successcount4)
    end
    within("#customer-#{@customer1.id}") do
      expect(page).to have_content(successcount5)
    end
  end
end