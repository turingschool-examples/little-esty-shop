require 'rails_helper'

RSpec.describe 'Admin invoices index page' do
  before :each do
    @cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
    @cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")
    @cust_3 = Customer.create!(first_name: "Brian", last_name: "Twinlegs")
    @cust_4 = Customer.create!(first_name: "Jared", last_name: "Goffleg")
    @cust_5 = Customer.create!(first_name: "Pistol", last_name: "Pete")
    @cust_6 = Customer.create!(first_name: "Bronson", last_name: "Shmonson")
    @cust_7 = Customer.create!(first_name: "Anten", last_name: "Branden")
    @invoice_1 = @cust_1.invoices.create!(status: 1)
    @invoice_2 = @cust_1.invoices.create!(status: 1)
    @invoice_3 = @cust_1.invoices.create!(status: 1)
    @invoice_4 = @cust_2.invoices.create!(status: 1)
    @invoice_5 = @cust_2.invoices.create!(status: 1)
    @invoice_6 = @cust_2.invoices.create!(status: 1)
    @invoice_7 = @cust_3.invoices.create!(status: 1)
    @invoice_8 = @cust_3.invoices.create!(status: 1)
    @invoice_9 = @cust_4.invoices.create!(status: 1)
    @invoice_10 = @cust_4.invoices.create!(status: 1)
    @invoice_11 = @cust_5.invoices.create!(status: 1)
    @invoice_12 = @cust_5.invoices.create!(status: 1)
    @invoice_13 = @cust_6.invoices.create!(status: 1)
    @invoice_14 = @cust_7.invoices.create!(status: 1)
    @invoice_15 = @cust_7.invoices.create!(status: 2)
  end

  it 'lists all invoice ids which are links to teh admin invoice show page' do
    visit "/admin/invoices"

    expect(page).to have_content(@invoice_1.id)
    within "#invoice-#{@invoice_1.id}" do
      click_link "#{@invoice_1.id}"
      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    end
    visit "/admin/invoices"
    expect(page).to have_content(@invoice_5.id)
      within "#invoice-#{@invoice_5.id}" do
        click_link "#{@invoice_5.id}"
        expect(current_path).to eq("/admin/invoices/#{@invoice_5.id}")
      end
    visit "/admin/invoices"
    expect(page).to have_content(@invoice_13.id)
      within "#invoice-#{@invoice_13.id}" do
        click_link "#{@invoice_13.id}"
        expect(current_path).to eq("/admin/invoices/#{@invoice_13.id}")
      end

  end
end