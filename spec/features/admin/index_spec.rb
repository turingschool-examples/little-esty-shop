require 'rails_helper'

RSpec.describe 'Admin Index' do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)
    
    invoice1 = create(:invoice, customer_id: @customer1.id)
    invoice2 = create(:invoice, customer_id: @customer2.id)
    invoice3 = create(:invoice, customer_id: @customer3.id)
    invoice4 = create(:invoice, customer_id: @customer4.id)
    invoice5 = create(:invoice, customer_id: @customer5.id)
    invoice6 = create(:invoice, customer_id: @customer6.id)

    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice1.id)
    transaction3 = create(:transaction, invoice_id: invoice2.id)
    transaction4 = create(:transaction, invoice_id: invoice3.id)
    transaction5 = create(:transaction, invoice_id: invoice4.id)
    transaction6 = create(:transaction, invoice_id: invoice5.id)
    transaction7 = create(:transaction, invoice_id: invoice6.id)

    Transaction.last(1).map { |t| t.update!(result: 1) }

    visit admin_index_path
  end

  describe 'Admin Dashboard' do
    it 'Visits the Admin Dash' do

      expect(page).to have_content('Admin Dashboard')
    end
  end

  describe 'Admin Dashboard links' do
    it 'has links to merchant/invoice index' do

      expect(page).to have_link('Admin Invoices')
      expect(page).to have_link('Admin Merchants')
    end
  end

  describe 'Admin Dashboard Statistics' do
    it 'displays the names of the top 5 customers and num of successful transcations' do

      expect(page).to have_content('Top 5 Customers')

      expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}: 3")
      expect(page).to have_content("#{@customer2.first_name} #{@customer2.last_name}: 2")
      expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name}: 2")
      expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name}: 2")
      expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name}: 2")
    end
  end
end
