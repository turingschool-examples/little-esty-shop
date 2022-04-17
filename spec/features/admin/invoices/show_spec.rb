require 'rails_helper'

RSpec.describe 'Admin invoice show page' do
  before :each do


    @customer1 = Customer.create!(first_name: "Loki", last_name: "R")

    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice2 = @customer1.invoices.create!(status: 1)


    @invoiceitem1 = @invoice1.invoice_items.create!(
                          quantity: 1,
                          unit_price:75107,
                          status: 1
                         )

    @invoiceitem2 = @invoice1.invoice_items.create!(
                          quantity: 1,
                          unit_price:75000,
                          status: 0
                         )
    @invoiceitem3 = @invoice2.invoice_items.create!(
                          quantity: 1,
                          unit_price:7500,
                          status: 1
                         )


    visit "/admin/invoices/#{@invoice1.id}"
  end

  it 'has header' do
    expect(page).to have_content("Invoice #{@invoice1.id}")
  end

  it 'shows all invoice attributes' do
    within("#invoice") do
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.created_at.strftime("%A, %b %d, %Y"))
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
    end
  end

  it 'shows all item attributes on the invoice' do
    within("#invoice_item-#{@invoiceitem1.id}") do
      expect(page).to have_content(@invoiceitem1.quantity)
      expect(page).to have_content(@invoiceitem1.unit_price)
      expect(page).to have_content(@invoiceitem1.status)
    end
  end

end
