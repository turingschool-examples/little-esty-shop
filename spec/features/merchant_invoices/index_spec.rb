require 'rails_helper'
# FactoryBot.find_definitions

RSpec.describe 'index page' do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @items = create_list(:item, 5, merchant: @merchant)
    @invoices = create_list(:invoice, 5, customer: @customer)

    @items.zip(@invoices) do |item, invoice|
      create(:invoice_item, item: item, invoice: invoice)
    end

    visit "/merchants/#{@merchant.id}/invoices"
  end

  it "shows all invoices that include the given merchant's items" do
    @invoices.each do |invoice|
      expect(page).to have_content(invoice.id)
    end
  end
end
