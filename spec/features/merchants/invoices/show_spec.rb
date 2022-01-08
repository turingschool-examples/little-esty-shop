require 'rails_helper'

RSpec.describe 'merchant invoices show page' do
  it 'lists items for an invoice and their attributes' do
    merchant = Merchant.create!(name: 'merchant name')
    not_included_merchant = Merchant.create!(name: 'merchant name')
    customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    item_1 = Item.create!(merchant_id: merchant.id, name: 'widget-1', description: 'widget description',
                          unit_price: 100)
    item_2 = Item.create!(merchant_id: merchant.id, name: 'widget-2', description: 'widget description',
                          unit_price: 200)
    item_3 = Item.create!(merchant_id: merchant.id, name: 'widget-3', description: 'widget description',
                          unit_price: 300)
    item_4 = Item.create!(merchant_id: merchant.id, name: 'widget-4', description: 'widget description',
                          unit_price: 400)
    item_5 = Item.create!(merchant_id: not_included_merchant.id, name: 'widget-20', description: 'widget description',
                          unit_price: 40440)

    invoice = Invoice.create!(customer_id: customer.id, status: 'completed')
    invoice_2 = Invoice.create!(customer_id: customer.id, status: 'completed')
    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_1.id, quantity: 7,
                                         unit_price: 100)
    invoice_item_2 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_2.id, quantity: 3,
                                         unit_price: 200)
    invoice_item_3 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_3.id, quantity: 2,
                                         unit_price: 300)
    invoice_item_4 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_4.id, quantity: 2,
                                         unit_price: 400)

    invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_5.id, quantity: 1,
                                         unit_price: 700)

    visit merchant_invoice_path(merchant, invoice)

    within '.header' do
      expect(page).to have_content("Invoice ##{invoice.id}")
    end

    within '.invoice-items' do
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_4.name)
      expect(page).to have_content((item_1.unit_price / 100.to_f).to_s.prepend('$').ljust(5, '0'))
      expect(page).to have_content((item_2.unit_price / 100.to_f).to_s.prepend('$').ljust(5, '0'))
      expect(page).to have_content((item_3.unit_price / 100.to_f).to_s.prepend('$').ljust(5, '0'))
      expect(page).to have_content((item_4.unit_price / 100.to_f).to_s.prepend('$').ljust(5, '0'))
      expect(page).to have_content(invoice_item_1.status)
      expect(page).to have_content(invoice_item_2.status)
      expect(page).to have_content(invoice_item_3.status)
      expect(page).to have_content(invoice_item_4.status)
      expect(page).to_not have_content(item_5.name)
    end
  end
end
