require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')
    @merchant_2 = Merchant.create!(name: 'Kozy Group')

    @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')

    @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
    @invoice_2 = Invoice.create!(status: 1, customer_id: "#{@customer.id}")

    visit "/admin"
  end

  it 'displays header indicating admin dashboard' do
    expect(page).to have_content("Admin Dashboard")
  end

  it 'displays a link to admin merchants index' do
    expect(page).to have_link("Merchants")
  end

  it 'displays a link to admin invoices index' do
    expect(page).to have_link("Invoices")
  end

  it 'the link directs the user to the merchant index' do
    click_on "Merchants"

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content(Merchant.first.name)
    expect(page).to have_content(Merchant.last.name)
  end

  it 'the link directs the user to the invoice index' do
    click_on "Invoices"
    save_and_open_page
    expect(current_path).to eq("/admin/invoices")
    expect(page).to have_content(Invoice.first.id)
    expect(page).to have_content(Invoice.last.id)
  end
end
