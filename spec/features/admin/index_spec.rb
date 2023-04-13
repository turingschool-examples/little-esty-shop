require 'rails_helper'

RSpec.describe 'Admin Index (Dashboard) Page', type: :feature do
  it 'has a header' do
    visit admin_path

    expect(page).to have_content('Admin Dashboard')
    expect(page).to have_selector('h2')
  end

  it 'has links to the admin merchants index and admin invoices index' do
    visit admin_path

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
      @customer_1 = create(:customer) # 5 successful transactions
      @customer_2 = create(:customer) # 4 successful transactions
      @customer_3 = create(:customer) # 3 successful transactions
      @customer_4 = create(:customer) # 2 successful transactions
      @customer_5 = create(:customer) # 1 successful transaction

      5.times do
        invoice = create(:invoice, customer: @customer_1)
        create(:transaction, result: true, invoice: invoice)
      end

      4.times do
        invoice = create(:invoice, customer: @customer_2)
        create(:transaction, result: true, invoice: invoice)
      end

      3.times do
        invoice = create(:invoice, customer: @customer_3)
        create(:transaction, result: true, invoice: invoice)
      end

      2.times do
        invoice = create(:invoice, customer: @customer_4)
        create(:transaction, result: true, invoice: invoice)
      end

      invoice = create(:invoice, customer: @customer_5)
      create(:transaction, result: true, invoice: invoice)
      create(:transaction, result: false, invoice: invoice)

      @customer_6 = create(:customer) # no successful transactions
      2.times do
        invoice = create(:invoice, customer: @customer_6)
        create(:transaction, result: false, invoice: invoice)
      end
    end

    it 'displays the top 5 customers with their names and number of successful transactions' do
      visit admin_path
      save_and_open_page

      expect(page).to have_content("Top Customers")

      within("#customer-#{@customer_1.id}") do
        expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
        expect(page).to have_content("5 purchases")
      end

      within("#customer-#{@customer_2.id}") do
        expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}")
        expect(page).to have_content("4 purchases")
      end

      within("#customer-#{@customer_3.id}") do
        expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}")
        expect(page).to have_content("3 purchases")
      end

      within("#customer-#{@customer_4.id}") do
        expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}")
        expect(page).to have_content("2 purchases")
      end

      within("#customer-#{@customer_5.id}") do
        expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}")
        expect(page).to have_content("1 purchases")
      end

      expect(@customer_1.first_name).to appear_before(@customer_2.first_name)
      expect(@customer_2.first_name).to appear_before(@customer_3.first_name)
      expect(@customer_3.first_name).to appear_before(@customer_4.first_name)
      expect(@customer_4.first_name).to appear_before(@customer_5.first_name)

      expect(page).to_not have_content(@customer_6.first_name)
      expect(page).to_not have_content(@customer_6.last_name)
    end
  end
end

