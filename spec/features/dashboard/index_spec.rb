require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Name')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Coon')

    @invoice_1 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_6.id, status: 1)

    visit merchant_dashboard_index_path(@merchant1)
  end

  it 'shows the merchant name' do
    expect(page).to have_content(@merchant1.name)
  end

  it 'can see a link to my merchant items index' do
    expect(page).to have_link("Items")

    click_link "Items"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/items")
  end

  it 'can see a link to my merchant invoices index' do
    expect(page).to have_link("Invoices")

    click_link "Invoices"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/invoices")
  end

  xit 'shows the names of the top 5 customers with successful transactions' do
    within("#customer-#{@customer_1.id}") do
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to have_content(2)
    end
    within("#customer-#{@customer_2.id}") do
      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_2.last_name)
      expect(page).to have_content(1)
    end
    within("#customer-#{@customer_3.id}") do
      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_3.last_name)
      expect(page).to have_content(1)
    end
    within("#customer-#{@customer_4.id}") do
      expect(page).to have_content(@customer_4.first_name)
      expect(page).to have_content(@customer_4.last_name)
      expect(page).to have_content(1)
    end
    within("#customer-#{@customer_5.id}") do
      expect(page).to have_content(@customer_5.first_name)
      expect(page).to have_content(@customer_5.last_name)
      expect(page).to have_content(1)
    end
    expect(page).to have_no_content(@customer_6.first_name)
    expect(page).to have_no_content(@customer_6.last_name)
  end
end
