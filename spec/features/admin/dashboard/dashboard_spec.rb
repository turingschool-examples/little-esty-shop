require 'rails_helper'

describe 'dashboard' do
  describe 'user story 19' do
    it 'should have a header \'admin dashboard\'' do
      visit '/admin'
      within('header') do
        expect(page).to have_css('h1', text: "Admin Dashboard")
      end
    end
  end

  describe 'user story 20' do
    it 'should have a link to admin merchants index' do
      visit '/admin'
      expect(page).to have_link('Admin Merchants', href: '/admin/merchants')
    end

    it 'should have a link to admin invoices index' do
      visit '/admin'
      expect(page).to have_link('Admin Invoices', href: '/admin/invoices')
    end
  end 

  describe 'user story 21' do
    it 'should have a list of the top 5 customers' do
    customer1 = create(:customer)
    customer2 = create(:customer)
    customer3 = create(:customer)
    customer4 = create(:customer)
    customer5 = create(:customer)
    customer6 = create(:customer)
    customer7 = create(:customer)
    customer8 = create(:customer)
    invoice1 = create(:invoice, customer_id: customer1.id)
    invoice2 = create(:invoice, customer_id: customer2.id)
    invoice3 = create(:invoice, customer_id: customer3.id)
    invoice4 = create(:invoice, customer_id: customer4.id)
    invoice5 = create(:invoice, customer_id: customer5.id)
    invoice6 = create(:invoice, customer_id: customer6.id)
    invoice7 = create(:invoice, customer_id: customer7.id)
    invoice8 = create(:invoice, customer_id: customer8.id)
    transaction1_1 = create(:transaction, invoice_id: invoice1.id)
    transaction1_2 = create(:transaction, invoice_id: invoice1.id)
    transaction1_3 = create(:transaction, invoice_id: invoice1.id)
    transaction2_1 = create(:transaction, invoice_id: invoice2.id)
    transaction2_2 = create(:transaction, invoice_id: invoice2.id)
    transaction3_1 = create(:transaction, invoice_id: invoice3.id)
    transaction3_2 = create(:transaction, invoice_id: invoice3.id)
    transaction4_1 = create(:transaction, invoice_id: invoice4.id)
    transaction4_2 = create(:transaction, invoice_id: invoice4.id)
    transaction5_1 = create(:transaction, invoice_id: invoice5.id)
    transaction5_1 = create(:transaction, invoice_id: invoice5.id)
    transaction6 = create(:transaction, invoice_id: invoice6.id)
    transaction7 = create(:transaction, invoice_id: invoice7.id)
    transaction8 = create(:transaction, invoice_id: invoice8.id)
    visit '/admin'
    expect(page).to have_content('Top 5 Customers')
    expect(page).to have_content("#{customer1.first_name + " " + customer1.last_name}: 3 transactions")
    expect(page).to have_content("#{customer2.first_name + " " + customer2.last_name}: 2 transactions")
    expect(page).to have_content("#{customer3.first_name + " " + customer3.last_name}: 2 transactions")
    expect(page).to have_content("#{customer4.first_name + " " + customer4.last_name}: 2 transactions")
    expect(page).to have_content("#{customer5.first_name + " " + customer5.last_name}: 2 transactions")
    end
  end
  

end