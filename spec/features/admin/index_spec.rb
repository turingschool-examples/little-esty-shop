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
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)

      @customers = [@customer_1, @customer_2, @customer_3, @customer_4, @customer_5]

      @customers.each do |customer|
        2.times do
          invoice = create(:invoice, customer: customer)
          create(:transaction, result: true, invoice: invoice)
        end
      end

      invoice = @customer_5.invoices.first
      create(:transaction, result: true, invoice: invoice)

      @customer_6 = create(:customer)
      2.times do
        invoice = create(:invoice, customer: @customer_6)
        create(:transaction, result: false, invoice: invoice)
      end
    end

    it 'displays the top 5 customers with their names and number of successful transactions' do
      expect(page).to_not have_content(@customer_6.name)

      within("#customer-#{@customer_1.id}") do
        expect(page).to have_content(@customer_1.name)
        expect(page).to have_content('2')
        expect(@customer_1.name).to_appear_before('2')
      end

      within("#customer-#{@customer_2.id}") do
        expect(page).to have_content(@customer_2.name)
        expect(page).to have_content('2')
        expect(@customer_2.name).to_appear_before('2')
      end

      within("#customer-#{@customer_3.id}") do
        expect(page).to have_content(@customer_3.name)
        expect(page).to have_content('2')
        expect(@customer_3.name).to_appear_before('2')
      end

      within("#customer-#{@customer_4.id}") do
        expect(page).to have_content(@customer_4.name)
        expect(page).to have_content('2')
        expect(@customer_4.name).to_appear_before('2')
      end

      within("#customer-#{@customer_5.id}") do
        expect(page).to have_content(@customer_5.name)
        expect(page).to have_content('3')
        expect(@customer_5.name).to_appear_before('3')
      end
    end
  end
end

