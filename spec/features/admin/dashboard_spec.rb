require 'rails_helper'
require 'csv'

RSpec.describe 'admin dashboard' do
  before(:all) do
    Rails.application.load_seed
  end

  it 'has a header for the page name' do
    visit '/admin'
    expect(page).to have_content("Admin Dashboard")
  end

  it 'has links to the admin merch and invoices indices' do
    visit admin_index_path
    expect(page).to have_link 'Merchants Index', href: admin_merchants_path
    expect(page).to have_link 'Invoices Index', href: admin_invoices_path
    click_link("Merchants Index")
    expect(current_path).to eq("/admin/merchants")
    visit admin_index_path
    click_link("Invoices Index")
    expect(current_path).to eq("/admin/invoices")
  end


  it 'has top customer statistics visible' do
    visit admin_index_path
   
    within "#top_5_customers" do
      expect(page).to have_content("Top 5 Customers by Successful Transactions:")
      save_and_open_page
      expect("1. #{Customer.third.first_name} #{Customer.third.last_name}").to appear_before("2. #{Customer.fifth.first_name} #{Customer.fifth.last_name}")
      expect("2. #{Customer.fifth.first_name} #{Customer.fifth.last_name}").to appear_before("3. #{Customer.second.first_name} #{Customer.second.last_name}")
      expect("3. #{Customer.second.first_name} #{Customer.second.last_name}").to appear_before("4. #{Customer.fourth.first_name} #{Customer.fourth.last_name}")
      expect("4. #{Customer.fourth.first_name} #{Customer.fourth.last_name}").to appear_before("5. #{Customer.last.first_name} #{Customer.last.last_name}")
    end

    within "#top_5_customers" do
      expect(page).to have_content("1. #{Customer.third.first_name} #{Customer.third.last_name} Successful Transactions: 5")
      expect(page).to have_content("2. #{Customer.fifth.first_name} #{Customer.fifth.last_name} Successful Transactions: 4")
      expect(page).to have_content("3. #{Customer.second.first_name} #{Customer.second.last_name} Successful Transactions: 3")
      expect(page).to have_content("4. #{Customer.fourth.first_name} #{Customer.fourth.last_name} Successful Transactions: 2")
      expect(page).to have_content("5. #{Customer.last.first_name} #{Customer.last.last_name} Successful Transactions: 1")
    end


  end

end