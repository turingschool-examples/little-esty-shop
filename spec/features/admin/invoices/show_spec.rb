require 'rails_helper'

RSpec.describe "admin/invoices#show" do
  before :each do
    test_data
  end


  it 'has invoice ID' do
    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content(@invoice_1.id)
  end

  it 'has status' do
    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content(@invoice_1.status)
  end

  it 'has created at formatted' do
    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content(@invoice_1.created_at_formatted)
  end

  it 'has customer first and last name' do
    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content("#{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
  end

  it 'lists item names' do
    visit admin_invoice_path(@invoice_1)
    
    expect(page).to have_content("#{@item_1.name}")
    expect(page).to have_content("#{@item_10.name}")
  end

  xit 'lists quantity' do
    visit admin_invoice_path(@invoice_1)
    
    #probably a within here
    expect(page).to have_content("Quantity: #{@invoice_item_1.quantity}")
    expect(page).to have_content("Quantity: #{@invoice_item_10.quantity}")
  end

  xit 'shows price sold for' do
    visit admin_invoice_path(@invoice_1)
    
    expect(page).to have_content("Quantity: #{@invoice_item_1.unit_price}")
    expect(page).to have_content("Quantity: #{@invoice_item_10.unit_price}")
  end

  xit 'shows invoice_item status' do
    visit admin_invoice_path(@invoice_1)
    
    expect(page).to have_content("Quantity: #{@invoice_item_1.status}")
    expect(page).to have_content("Quantity: #{@invoice_item_10.status}")
  end

  xit 'shows the total revenue' do
    visit admin_invoice_path(@invoice_1)
    
    expect(page).to have_content("Quantity: #{@invoice_item_1.total_revenue}")
    expect(page).to have_content("Quantity: #{@invoice_item_10.total_revenue}")
  end
end