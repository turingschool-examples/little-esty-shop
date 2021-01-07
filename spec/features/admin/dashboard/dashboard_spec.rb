require 'rails_helper'

describe 'As an Admin' do
  describe 'When I visit the admin dashboard' do
    before :each do
      @merchant = Merchant.create!(name: 'House of thingys')

      @customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe')
      @customer_2 = Customer.create!(first_name: 'Meg', last_name: 'Clain')
      @customer_3 = Customer.create!(first_name: 'Bob', last_name: 'Alves')
      @customer_4 = Customer.create!(first_name: 'Tran', last_name: 'Smith')
      @customer_5 = Customer.create!(first_name: 'Mary', last_name: 'Dumas')
      @customer_6 = Customer.create!(first_name: 'James', last_name: 'Core')

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant.id, status: 0)
      @invoice_2 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant.id, status: 1)
      @invoice_3 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant.id, status: 2)
      @invoice_4 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant.id, status: 0)
      end

    it 'I see Im in the admins dashboard with links to mechants and invoices' do
      visit admin_index_path

      expect(page).to have_content('Admin Dashboard')
      expect(page).to have_link("Admin Merchants")
      expect(page).to have_link("Admin Invoices")
    end

    it 'I see a section for Incomplete Invoices' do

    visit admin_index_path

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_4.id)
    expect(page).to_not have_content(@invoice_2.id)
    expect(page).to_not have_content(@invoice_3.id)
    end
  end
end
