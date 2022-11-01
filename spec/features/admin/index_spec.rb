require 'rails_helper'

RSpec.describe 'Admin Index' do
  before :each do 
    @customer_1 = Customer.create!(first_name: "Sally" last_name: "Shopper")
    @customer_2 = Customer.create!(first_name: "Evan" last_name: "East")
    @customer_3 = Customer.create!(first_name: "Yasha" last_name: "West")
    @customer_4 = Customer.create!(first_name: "Du" last_name: "North")
    @customer_5 = Customer.create!(first_name: "Polly" last_name: "South")
    
    
    visit '/admin'
  end

  it "has a header" do 
    expect(page).to have_content("Admin Dashboard")
  end

  it "has links" do 
    expect(page).to have_link('admin merchants index')
    expect(page).to have_link('admin invoices index')
  end

  it "shows top 5 customers with most sucessful transactions" do 
    expect(page).to have_content("Top Customers")
    expect(page).to have_content("")
    expect(page).to have_content("")
    expect(page).to have_content("")
    expect(page).to have_content("")
    expect(page).to_not have_content("")
    expect(page).to_not have_content("")

  end


end