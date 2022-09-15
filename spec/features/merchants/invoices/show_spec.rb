require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page', type: :feature do

  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @invoice_1 = create(:invoice, status: 0)
    @invoice_1.items << @item_1

    visit merchant_invoice_path(@merchant_1.id, @invoice_1.id)
  end

  it 'shows the status of the invoice' do
    expect(page).to have_content("Status: In Progress")
  end

  it 'shows the date created in the correct format' do
    expect(page).to have_content("Created On: #{@invoice_1.created_at.strftime("%A, %B %-d, %Y")}")
  end

  it 'shows the customer name' do
    customer = @invoice_1.customer
    expect(page).to have_content("Customer:\n#{customer.first_name} #{customer.last_name}")
  end

end