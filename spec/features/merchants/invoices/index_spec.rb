require 'rails_helper'

RSpec.describe 'Merchant Invoices Index Page', type: :feature do

  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)

    @merchant_2 = create(:merchant)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)

    @invoice_1.items << [@item_1, @item_2, @item_3]
    @invoice_2.items << [@item_3, @item_4]
    @invoice_3.items << [@item_1, @item_4]
    @invoice_4.items << @item_2

    @invoice_1.invoice_items.each do |invoice_item|
      invoice_item.update!(status: :pending)
    end
  end

  it 'lists the invoices that contain an item sold by the merchant' do
    visit merchant_invoices_path(@merchant_1.id)
    expect(page).to have_content("My Invoices")
    within("li#invoice_#{@invoice_1.id}") { expect(page).to have_content("Invoice ##{@invoice_1.id}") }
    within("li#invoice_#{@invoice_3.id}") { expect(page).to have_content("Invoice ##{@invoice_3.id}") }
    within("li#invoice_#{@invoice_4.id}") { expect(page).to have_content("Invoice ##{@invoice_4.id}") }
  end

  it 'has invoice numbers that are links to an invoice show page' do
    visit merchant_invoices_path(@merchant_1.id)
    within("li#invoice_#{@invoice_1.id}") do
      expect(page).to have_link("#{@invoice_1.id}")
      click_link("#{@invoice_1.id}")
      expect(current_path).to eq(merchant_invoice_path(@merchant_1.id, @invoice_1.id))
    end
  end

end