require "rails_helper"

describe "Merchants Invoicess index", type: :feature do
  before do
    @merchant1 = create(:merchant)
    @items1 = create_list(:item, 3, merchant: @merchant1)
    @customer1 = create(:customer)
    @invoices = create_list(:invoice, 3, customer: @customer1)
    @invoice_item1 = create(:invoice_item, invoice: @invoices.first, item: @items1.first)
    @invoice_item2 = create(:invoice_item, invoice: @invoices.second, item: @items1.second)
    @invoice_item3 = create(:invoice_item, invoice: @invoices.last, item: @items1.last)
  end

  describe "display" do
    it "displays all invoices for this merchant" do
      visit merchant_invoices_path(@merchant1.id)

      within "#invoice-#{@invoices.first.id}" do
        expect(page).to have_link(@invoices.first.id)
        expect(page).to_not have_link(@invoices.second.id)
        expect(page).to_not have_link(@invoices.last.id)
      end

      within "#invoice-#{@invoices.second.id}" do
        expect(page).to have_link(@invoices.second.id)
      end

      within "#invoice-#{@invoices.last.id}" do
        expect(page).to have_link(@invoices.last.id)
        click_link @invoices.last.id
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoices.last.id}")
    end
  end
end
