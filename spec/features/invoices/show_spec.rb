require 'rails_helper'

RSpec.describe 'Merchant Invoices Show' do
  before :each do
    @merchants = create_list(:merchant, 3)
    @items1 = create_list(:item, 3, merchant: @merchants.first)
    @items2 = create_list(:item, 4, merchant: @merchants.second)
    @customers = create_list(:customer, 2)

    @invoices1 = create_list(:invoice, 3, customer: @customers.first)
    @invoice_item1 = create(:invoice_item, invoice: @invoices1.first, item: @items1.first)
    @invoice_item2 = create(:invoice_item, invoice: @invoices1.second, item: @items1.second)
    @invoice_item3 = create(:invoice_item, invoice: @invoices1.last, item: @items1.last)

    @invoices2 = create_list(:invoice, 2, customer: @customers.second)
    @invoice_item6 = create(:invoice_item, invoice: @invoices2.first, item: @items1.first)
    @invoice_item4 = create(:invoice_item, invoice: @invoices2.last, item: @items1.last)

    visit merchant_invoice_path(@merchants.first, @invoices1.first)
  end

  describe 'display' do
    it 'invoice attributes' do
      expect(page).to have_content(@invoices1.first.id)
      expect(page).to have_content("Status: In Progress")
      expect(page).to have_content("Created On: #{@invoices1.first.created_at.strftime('%A, %B %d, %Y')}")
      expect(page).to have_content(@invoices1.first.customer.full_name)
      expect(page).to_not have_content(@invoices1.second)
      expect(page).to_not have_content(@invoices1.last)
    end

  end
end