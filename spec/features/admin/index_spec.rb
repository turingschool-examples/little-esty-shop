require 'rails_helper'

RSpec.describe 'Admin Index (Dashboard) Page', type: :feature do
  before(:each) do
    visit admin_path
  end

  it 'has a header' do
    expect(page).to have_content('Admin Dashboard')
    expect(page).to have_selector('h1')
  end

  it 'has links to the admin merchants index and admin invoices index' do
    expect(page).to have_link('Admin Merchants Index')
    expect(page).to have_link('Admin Invoices Index')

    click_link('Admin Merchants Index')
    expect(current_path).to eq(admin_merchants_path)

    visit admin_path
    click_link('Admin Invoices Index')
    expect(current_path).to eq(admin_invoices_path)
  end

  it 'displays the top 5 customers with their names and number of successful transactions' do


    within("#customer-#{.id}") do # add customer variable
      expect(page).to have_content() #customer name 1
      expect(page).to have_content() #add number of successful transactions
      expect().to_appear_before()  #name to appear before transactions count
    end

    within("#customer-#{.id}") do # add customer variable
      expect(page).to have_content() #customer name 2
      expect(page).to have_content() #add number of successful transactions
      expect().to_appear_before()  #name to appear before transactions count
    end

    within("#customer-#{.id}") do # add customer variable
      expect(page).to have_content() #customer name 3
      expect(page).to have_content() #add number of successful transactions
      expect().to_appear_before()  #name to appear before transactions count
    end

    within("#customer-#{.id}") do # add customer variable
      expect(page).to have_content() #customer name 4
      expect(page).to have_content() #add number of successful transactions
      expect().to_appear_before()  #name to appear before transactions count
    end

    within("#customer-#{.id}") do # add customer variable
      expect(page).to have_content() #customer name 5
      expect(page).to have_content() #add number of successful transactions
      expect().to_appear_before()  #name to appear before transactions count
    end
  end
end

Then I see the names of the top 5 customers
who have conducted the largest number of successful transactions
And next to each customer name I see the number of successful transactions they have
conducted