require 'rails_helper'

RSpec.describe 'Admin Invoice Index Page' do
  before :each do
    @customer = Customer.create(first_name: 'Tom', last_name: 'Holland')
    @i = Invoice.create!(status: 2, customer_id: @customer.id)

    visit '/admin/invoices'
  end

  it 'is on the correct page' do
    expect(current_path).to eq('/admin/invoices')
    expect(page).to have_content('Admin Invoices')
  end

  it 'can display all invoices' do

    expect(page).to have_content(@i.id)
    expect(page).to have_content(@i.status)
  end

  it 'can take user to admin invoice show page' do
    within "#invoice-#{@i.id}" do
      click_link "Show"
      expect(current_path).to eq("/admin/invoices/#{@i.id}")
    end
  end

  it 'can take user to invoice edit page' do
    within "#invoice-#{@i.id}" do
      click_link "Edit"
      expect(current_path).to eq("/admin/invoices/#{@i.id}/edit")
    end
  end

end
