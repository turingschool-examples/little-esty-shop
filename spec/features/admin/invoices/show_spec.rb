require 'rails_helper'

RSpec.describe 'Admin invoice show page' do
  before :each do

    @starw = Merchant.create!(name: "Star Wars R Us ")
    @start = Merchant.create!(name: "Star Trek R Us ")

    @item1 = @starw.items.create!(name:	"X-wing",
                          description: "X-wing ship",
                          unit_price:75107,
                          status: 1
                         )

    @item2 = @starw.items.create!(name:	"Tie-fighter",
                          description: "Tie-fighter ship",
                          unit_price:75000,
                          status: 0
                         )
    @item3 = @starw.items.create!(name:	"Lightsaber",
                          description: "Lightsaber",
                          unit_price:7500,
                          status: 1
                         )

    @item4 = @starw.items.create!(name:	"Luke",
                          description: "Luke SKywalker figure",
                          unit_price:1000
                         )

    @customer1 = Customer.create!(first_name: "Loki", last_name: "R")

    @invoice1 = @customer1.invoices.create!(status: 0)

    @invoice2 = @customer1.invoices.create!(status: 1)

    @invoiceitem1 = InvoiceItem.create(quantity: 1, unit_price: 100, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    @invoiceitem2 = InvoiceItem.create(quantity: 1, unit_price: 100, item_id: @item2.id, invoice_id: @invoice1.id, status: 1)
    @invoiceitem3 = InvoiceItem.create(quantity: 1, unit_price: 100, item_id: @item3.id, invoice_id: @invoice2.id, status: 0)

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
      expect(page).to have_content(@invoiceitem1.item.name)
      expect(page).to have_content(@invoiceitem1.quantity)
      expect(page).to have_content("Sale price: $1.00")
      expect(page).to have_content(@invoiceitem1.status)
    end
  end

end
