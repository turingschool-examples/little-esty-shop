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
    it "Shows top 5 customers" do
      merchant = Merchant.create!(name: 'House of thingys')

      customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe')
      customer_2 = Customer.create!(first_name: 'Meg', last_name: 'Clain')
      customer_3 = Customer.create!(first_name: 'Bob', last_name: 'Alves')
      customer_4 = Customer.create!(first_name: 'Tran', last_name: 'Smith')
      customer_5 = Customer.create!(first_name: 'Mary', last_name: 'Dumas')
      customer_6 = Customer.create!(first_name: 'James', last_name: 'Core')

      invoice_1 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant.id, status: 1)
      invoice_2 = Invoice.create!(customer_id: customer_2.id, merchant_id: merchant.id, status: 1)
      invoice_3 = Invoice.create!(customer_id: customer_3.id, merchant_id: merchant.id, status: 1)
      invoice_4 = Invoice.create!(customer_id: customer_4.id, merchant_id: merchant.id, status: 1)
      invoice_5 = Invoice.create!(customer_id: customer_5.id, merchant_id: merchant.id, status: 1)

      transaction_1 = invoice_1.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)
      transaction_2 = invoice_1.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)
      transaction_3 = invoice_2.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)
      transaction_4 = invoice_3.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)
      transaction_5 = invoice_4.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)
      transaction_6 = invoice_5.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)

      visit admin_index_path

      expect(page).to have_content("#{customer_1.first_name} #{customer_1.last_name}")
      expect(page).to have_content("#{customer_2.first_name} #{customer_2.last_name}")
      expect(page).to have_content("#{customer_3.first_name} #{customer_3.last_name}")
      expect(page).to have_content("#{customer_4.first_name} #{customer_4.last_name}")
      expect(page).to have_content("#{customer_5.first_name} #{customer_5.last_name}")
      expect(page).to_not have_content("#{customer_6.first_name} #{customer_6.last_name}")
    end
  end
end
