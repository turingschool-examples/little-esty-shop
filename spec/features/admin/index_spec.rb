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

  describe 'User Story 21' do
    before(:each) do
      5.times do
        customer = create(:customer)
        2.times do
          invoice = create(:invoice, customer: customer)
          create(:transaction, result: true, invoice: invoice)
        end
      end

      @most_transactions_customer = Customer.first
      invoice = @most_transactions_customer.invoices.first
      create(:transaction, result: true, invoice: invoice)

      @no_invoice_customer = create(:customer)
    end

    it 'displays the top 5 customers with their names and number of successful transactions' do
      require 'pry'; binding.pry
      # within("#customer-#{.id}") do # add customer variable
      #   expect(page).to have_content() #customer name 1
      #   expect(page).to have_content() #add number of successful transactions
      #   expect().to_appear_before()  #name to appear before transactions count
      # end

      # within("#customer-#{.id}") do # add customer variable
      #   expect(page).to have_content() #customer name 2
      #   expect(page).to have_content() #add number of successful transactions
      #   expect().to_appear_before()  #name to appear before transactions count
      # end

      # within("#customer-#{.id}") do # add customer variable
      #   expect(page).to have_content() #customer name 3
      #   expect(page).to have_content() #add number of successful transactions
      #   expect().to_appear_before()  #name to appear before transactions count
      # end

      # within("#customer-#{.id}") do # add customer variable
      #   expect(page).to have_content() #customer name 4
      #   expect(page).to have_content() #add number of successful transactions
      #   expect().to_appear_before()  #name to appear before transactions count
      # end

      # within("#customer-#{.id}") do # add customer variable
      #   expect(page).to have_content() #customer name 5
      #   expect(page).to have_content() #add number of successful transactions
      #   expect().to_appear_before()  #name to appear before transactions count
        expect(true).to eq(false)
      # end
    end
  end
end

