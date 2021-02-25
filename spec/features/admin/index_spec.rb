require 'rails_helper'
describe 'Admin Dashboard' do
  before :each do
    @customers = []
    10.times {@customers << create(:customer)}
    @customers.each do |customer|
      create(:invoice, customer_id: customer.id)
    end
    @invoice_id_1 = @customers.first.invoices.first.id
    @invoice_id_2 = @customers.second.invoices.first.id
    @invoice_id_3 = @customers.third.invoices.first.id
    @invoice_id_4 = @customers.fourth.invoices.first.id
    @invoice_id_5 = @customers.fifth.invoices.first.id
    @invoice_id_6 = @customers[5].invoices.first.id
    @invoice_id_7 = @customers[6].invoices.first.id
    9.times {create(:transaction, invoice_id: @invoice_id_1, result: 0)}
    7.times {create(:transaction, invoice_id: @invoice_id_2, result: 0)}
    7.times {create(:transaction, invoice_id: @invoice_id_3, result: 0)}
    7.times {create(:transaction, invoice_id: @invoice_id_4, result: 0)}
    1.times {create(:transaction, invoice_id: @invoice_id_5, result: 0)}
    1.times {create(:transaction, invoice_id: @invoice_id_6, result: 1)}
    10.times {create(:transaction, invoice_id: @invoice_id_7, result: 1)}
  end

  it 'displays a header' do
    visit '/admin'

    expect(page).to have_content("Admin Dashboard")
  end

  it 'Shows links to merchant and invoice index pages' do
    visit '/admin'
    
    expect(page).to have_link("Merchant Index")
    expect(page).to have_link("Invoice Index")
  end

  it 'Shows names of top 5 customers with largest number of transactions' do
    visit '/admin'

    expect(@customers.first.first_name).to appear_before(@customers.second.first_name)
    expect(@customers.first.last_name).to appear_before(@customers.second.last_name)
    expect(@customers.first.first_name).to appear_before(@customers.third.first_name)
    expect(@customers.first.last_name).to appear_before(@customers.third.last_name)
    expect(@customers.first.first_name).to appear_before(@customers.fourth.first_name)
    expect(@customers.first.last_name).to appear_before(@customers.fourth.last_name)
    expect(page).to_not have_content(@customers[6].first_name)
    expect(page).to_not have_content(@customers[6].last_name)
  end
end