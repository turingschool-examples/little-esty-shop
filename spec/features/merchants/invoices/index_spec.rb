require 'rails_helper'

RSpec.describe 'merchants invoices index page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
    @merchant2 = Merchant.create!(name: 'Jays Foot Made Jewlery')

    @item1 = @merchant1.items.create!(name: 'Chips', description: 'Ring', unit_price: 20)
    @item2 = @merchant1.items.create!(name: 'darrel', description: 'Bracelet', unit_price: 40)
    @item3 = @merchant1.items.create!(name: 'don', description: 'Necklace', unit_price: 30)
    @item4 = @merchant2.items.create!(name: 'fake', description: 'Toe Ring', unit_price: 30)

    @customer1 = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
    @customer2 = Customer.create!(first_name: 'William', last_name: 'Lampke')

    @invoice1 = @customer1.invoices.create!(status: 1)
    @invoice2 = @customer1.invoices.create!(status: 1)
    @invoice3 = @customer1.invoices.create!(status: 1)
    @invoice4 = @customer2.invoices.create!(status: 1)

    @transaction1 = @invoice1.transactions.create!(credit_card_number: '123456789', credit_card_expiration_date: '05/07')
    @transaction2 = @invoice2.transactions.create!(credit_card_number: '987654321', credit_card_expiration_date: '04/07')
    @transaction3 = @invoice3.transactions.create!(credit_card_number: '543219876', credit_card_expiration_date: '03/07')
    @transaction4 = @invoice4.transactions.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07')

    @ii1 = InvoiceItem.create!(quantity: 5, unit_price: @item1.unit_price, item_id: @item1.id, invoice_id: @invoice1.id)
    @ii2 = InvoiceItem.create!(quantity: 5, unit_price: @item2.unit_price, item_id: @item2.id, invoice_id: @invoice2.id)
    @ii4 = InvoiceItem.create!(quantity: 5, unit_price: @item4.unit_price, item_id: @item4.id, invoice_id: @invoice4.id)
  end

  it 'lists all invoices with 1 or more of the merchants items' do
    visit merchant_invoices_path(@merchant1)

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice2.id)
    expect(page).to have_no_content(@invoice3.id)
    expect(page).to have_no_content(@invoice4.id)
  end

  it 'displays each invoice id as a link to the merchant invoice show page' do
    visit merchant_invoices_path(@merchant1)

    expect(page).to have_link @invoice1.id, href: merchant_invoices_show_path(@invoice1)
    expect(page).to have_link @invoice2.id, href: merchant_invoices_show_path(@invoice2)
    expect(page).to have_no_link @invoice3.id, href: merchant_invoices_show_path(@invoice3)
  end
end
