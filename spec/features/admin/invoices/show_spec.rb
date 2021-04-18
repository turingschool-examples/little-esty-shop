require 'rails_helper'

RSpec.describe 'when I visit the admin invoices show page' do
  before(:each) do
    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, status: 'in progress')
    @customer_1.invoices << [@invoice_1]
  end

 it 'can see invoice id, status, created_at date, customer first and last name' do
  visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
  end

  it 'allows user to select and change the invoices current status' do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content('in progress')
    select('completed', from: :status)
    click_button('Update Invoice Status')
    expect(page). to have_content('completed')
  end
end
