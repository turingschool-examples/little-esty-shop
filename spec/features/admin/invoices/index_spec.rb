require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page' do
  before :each do
    @customer1 = Customer.create!(first_name: "Bobby", last_name: "Mendez")
    @invoice1 = Invoice.create!(status: "in progess", customer_id: @customer1.id)

    visit "/admin/invoices"
  end
  
  it 'can visit the admin invoices page and display all invoice ids' do

    expect(page).to have_content(@invoice1.id)
  end

  it 'can click on the invoice id and take it to the invoices show page' do
    expect(page).to have_link("#{@invoice1.id}", href: "/admin/invoices/#{@invoice1.id}") 

    click_on "#{@invoice1.id}"

    expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
  end
end