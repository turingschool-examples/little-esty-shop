require "rails_helper"

describe "Merchants Invoicess index", type: :feature do
  before do
    @merchant1 = create(:merchant)
    @items1 = create_list(:item, 3, merchant: @merchant1)
    @customer1 = create(:customer)
    @invoices = create_list(:invoice, 3, customer: @customer1)
    @invoice_item1 = create(:invoice_item, invoice: @invoices[0], item: @items1[0])
    @invoice_item2 = create(:invoice_item, invoice: @invoices[1], item: @items1[1])
    @invoice_item3 = create(:invoice_item, invoice: @invoices[2], item: @items1[2])
  end

  describe "display" do
    it "displays all invoices for this merchant", :vcr do
      visit merchant_invoices_path(@merchant1)

      within "#invoice-#{@invoices[0].id}" do
        expect(page).to have_link(@invoices[0].id)
        expect(page).to_not have_link(@invoices[1].id)
        expect(page).to_not have_link(@invoices[2].id)
      end

      within "#invoice-#{@invoices[1].id}" do
        expect(page).to have_link(@invoices[1].id)
      end

      within "#invoice-#{@invoices[2].id}" do
        expect(page).to have_link(@invoices[2].id)
      end

      click_link @invoices[2].id
      expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoices[2]))
    end
  end
end
