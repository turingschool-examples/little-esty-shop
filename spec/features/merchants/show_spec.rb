require 'rails_helper'

RSpec.describe 'Merchant show page' do
  before :each do
    @bercy = Merchant.create!(name: "Bercy Hamhands' Homemade Hams")

    @cust1 = Customer.create!(name: "Bercy Hamhands")
    @cust2 = Customer.create!(name: "Django Fett")
    @cust3 = Customer.create!(name: "Big Chungus")
    @cust4 = Customer.create!(name: "Shake Zula")
    @cust5 = Customer.create!(name: "Some Donkus")

    @i1
    @i2
    @i3
    @i4


  end
  it "can see the name of the merchant at the merchant dashboard page" do
    visit "/merchants/#{@bercy.id}/dashboard"

    expect(page).to have_content(@bercy.name)
  end

  it "can see links to the item index page" do
    visit "/merchants/#{@bercy.id}/dashboard"

    click_link("My Items")

    expect(current_path).to eq("/items/index")
  end

  it "can see links to the invoice index page" do
    visit "/merchants/#{@bercy.id}/dashboard"

    click_link("My Invoices")

    expect(current_path).to eq("/invoices/index")
  end

  it "displays the top 5 best customers and their total sales" do
    visit "/merchants/#{@bercy.id}/dashboard"

    expect(page).to have_content(@cust1.name)
    expect(page).to have_content(@cust2.name)
    expect(page).to have_content(@cust3.name)
    expect(page).to have_content(@cust4.name)
    expect(page).to have_content(@cust5.name)
  end
end
