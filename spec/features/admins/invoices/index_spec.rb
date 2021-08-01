require 'rails_helper'

RSpec.describe 'Invoice Index', type: :feature do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')

    @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = Invoice.create!(status: 1, customer_id: "#{@customer_1.id}")
    @invoice_3 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: '2012-03-24 09:54:09 UTC')
    @invoice_4 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: '2012-03-23 09:54:09 UTC')
    @invoice_5 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: '2012-03-22 09:54:09 UTC')

    visit admin_invoices_path
  end

  it 'displays the name of each invoice in the system' do

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to have_content(@invoice_3.id)
    expect(page).to have_content(@invoice_4.id)
    expect(page).to have_content(@invoice_5.id)
  end

  it 'can link to an invoices show page' do

    click_link "Invoice # #{@invoice_1.id}"

    expect(current_path).to eq(admin_invoice_path(@invoice_1.id))
  end
end
