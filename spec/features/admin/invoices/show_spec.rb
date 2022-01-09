require 'rails_helper'

RSpec.describe 'admin invoice show page' do
  before(:each) do
    @invoice = FactoryBot.create(:invoice, status: "in progress")
    @invoice2 = FactoryBot.create(:invoice, status: "in progress")


    @item = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
    @item3 = FactoryBot.create(:item)
    @item4 = FactoryBot.create(:item)
    @item5 = FactoryBot.create(:item)

    @invoiceitem = FactoryBot.create(:invoice_item, invoice: @invoice, item: @item, unit_price: 1300, status: "pending" )
    @invoiceitem2 = FactoryBot.create(:invoice_item, invoice: @invoice, item: @item2, unit_price: 1400, status: "pending")
    @invoiceitem3 = FactoryBot.create(:invoice_item, invoice: @invoice, item: @item3, unit_price: 1500, status: "pending")
    @invoiceitem4 = FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item2)
    @invoiceitem5 = FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item3)
    @invoiceitem6 = FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item4)

    visit "/admin/invoices/#{@invoice.id}"
  end

  it 'shows invoice id' do
    expect(page).to have_content(@invoice.id)
  end

  it 'shows invoice status' do
    expect(page).to have_content(@invoice.status)
  end

  it 'shows invoice created_at in correct format' do
    expect(page).to have_content(@invoice.created_at.strftime("%A, %B %-d, %Y"))
  end

  it 'shows invoice customer first_name and last_name' do
    expect(page).to have_content(@invoice.customer_name)
  end

  it 'shows each item ordered with info' do
    within("#invoice-item-0") do
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@invoiceitem.quantity)
      expect(page).to have_content("$13.00")
      expect(page).to have_content(@invoiceitem.status)
    end
    within("#invoice-item-1") do
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@invoiceitem2.quantity)
      expect(page).to have_content("$14.00")
      expect(page).to have_content(@invoiceitem2.status)
    end
    within("#invoice-item-2") do
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@invoiceitem3.quantity)
      expect(page).to have_content("$15.00")
      expect(page).to have_content(@invoiceitem3.status)
    end
  end

  it 'shows invoice total revenue' do
    expect(page).to have_content("$#{@invoice.total_revenue.to_s.insert(-3, ".")}")
  end
end
