require 'rails_helper'

describe 'Admin Invoices Index Page' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')

    @c1 = Customer.create!(first_name: 'Yo', last_name: 'Yoz')
    @c2 = Customer.create!(first_name: 'Hey', last_name: 'Heyz')

    @i1 = Invoice.create!(merchant_id: @m1.id, customer_id: @c1.id, status: 2)
    @i2 = Invoice.create!(merchant_id: @m1.id, customer_id: @c1.id, status: 2)
    @i3 = Invoice.create!(merchant_id: @m1.id, customer_id: @c2.id, status: 2)
    @i4 = Invoice.create!(merchant_id: @m1.id, customer_id: @c2.id, status: 2)
    visit admin_invoices_path
  end

  it 'should list all invoice ids in the system as links to their show page' do
    expect(page).to have_link("Invoice ##{@i1.id}")
    expect(page).to have_link("Invoice ##{@i2.id}")
    expect(page).to have_link("Invoice ##{@i3.id}")
    expect(page).to have_link("Invoice ##{@i4.id}")
  end
end
